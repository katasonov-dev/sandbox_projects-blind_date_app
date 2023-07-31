class GroupsController < ApplicationController
  before_action :set_week

  def index
    @groups = Group.for_week(@week_number).page(params[:page])
  end

  def show
    @group = Group.find(params[:id])
    @employees = @group.employees
  end

  private

  def set_week
    @week_number = Date.today.cweek
  end
end
