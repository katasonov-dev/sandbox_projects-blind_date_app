class GroupsController < ApplicationController
  before_action :set_week

  def index
    @groups = Group.for_week(@week_number).page(params[:page])
  end

  def show
    @group = Group.find(params[:id])
    @employees = @group.users
  end

  def build_groups
    success_result = GroupBuilderService.new(@week_number).execute

    if success_result
      flash[:notice] = 'Groups successfully built!'
    else
      flash[:alert] = 'Failed to build groups. Please try again.'
    end

    redirect_to groups_path
  end

  private

  def set_week
    @week_number = Date.today.cweek
  end
end
