class GroupBuilderService
  MAX_GROUP_SIZE = 4

  attr_reader :week_number

  def initialize
    @week_number = Date.today.cweek
  end

  def execute
    grouped_employees = create_groups_for_week

    ActiveRecord::Base.transaction do
      groups_by_leader = assign_group_leaders(grouped_employees)

      groups_by_leader.each do |leader_id, employees|
        Group.create!(week_number: week_number, employees: employees, leader_id: leader_id)
      end
    end

  rescue => e
    Rails.logger.error(e)
  end

  private

  def create_groups_for_week
    groups_by_department = Employee.includes(:department).group_by(&:department)
    groups = randomize_groups(groups_by_department)

    divide_to_groups(groups)
  end

  def divide_to_groups(undistributed_groups)
    biggest_sub_group = undistributed_groups.max_by { |subarray| subarray.length }
    undistributed_groups.delete(biggest_sub_group)

    draft_groups = biggest_sub_group.zip(*undistributed_groups).flatten.each_slice(MAX_GROUP_SIZE).to_a
    groups = draft_groups.each(&:compact!).reject(&:empty?)

    if incomplete_groups = groups.select { |group| group.size < MAX_GROUP_SIZE }
      groups = groups - incomplete_groups
      redistributed_groups = redistribute_incomplete_groups(incomplete_groups)
      groups = groups + redistributed_groups
    end
    groups
  end

  def redistribute_incomplete_groups(groups)
    groups_by_department = groups.flatten.group_by { |employee| employee.department_id }
    groups = randomize_groups(groups_by_department)

    if groups.size < MAX_GROUP_SIZE
      groups = groups.flatten.shuffle.each_slice(MAX_GROUP_SIZE).to_a.reject { |group| group.size < MAX_GROUP_SIZE - 1 }
    else
      groups = divide_to_groups(groups)
    end
    groups
  end

  def randomize_groups(groups_by_department)
    groups_by_department.keys.shuffle!
    groups_by_department.values.map { |v| v.shuffle! }
  end

  def assign_group_leaders(groups)
    current_date = Date.today

    groups_by_leader = {}
    groups.each_with_index do |group|
      leader = group.select { |employee| employee.eligible_to_lead? }.first
      leader = group.shuffle.first unless leader

      leader.update!(group_leader_at: current_date)
      groups_by_leader[leader.id] = group
    end
    groups_by_leader
  end
end
