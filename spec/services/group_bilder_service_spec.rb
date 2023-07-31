require 'rails_helper'

RSpec.describe GroupBuilderService do
  describe '#execute' do
    let!(:department_1) { create(:department) }
    let!(:department_2) { create(:department) }
    let!(:department_3) { create(:department) }
    let!(:department_4) { create(:department) }
    let!(:department_5) { create(:department) }
    let!(:users_department_1) { create_list(:user, 4, department: department_1) }
    let!(:users_department_2) { create_list(:user, 4, department: department_2) }
    let!(:users_department_3) { create_list(:user, 4, department: department_3) }
    let!(:users_department_4) { create_list(:user, 4, department: department_4) }
    let!(:users_department_5) { create_list(:user, 3, department: department_5) }

    let(:date_today) { Date.today }
    let(:week_number) { date_today.cweek }
    let(:service) { described_class.new(week_number) }

    before do
      allow(Date).to receive(:today).and_return(date_today)
    end

    it 'creates groups with valid attributes and leaders' do
      groups = Group.where(week_number: week_number)

      expect { service.execute }.to change { Group.count }.by(5)
      expect(groups).to all(have_attributes(week_number: week_number))

      groups.each do |group|
        leader_count = group.users.where(group_leader_at: date_today).count
        expect(leader_count).to eq(1)
      end
    end

    it 'logs error and does not raise exception on failure' do
      allow_any_instance_of(GroupBuilderService).to receive(:create_groups_for_week).and_raise(StandardError)

      expect(Rails.logger).to receive(:error).once

      service.execute
    end
  end
end
