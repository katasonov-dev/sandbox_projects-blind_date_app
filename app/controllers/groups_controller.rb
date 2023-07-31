class GroupsController < ApplicationController
  before_action :set_week

  def index
    @groups = Group.where(
      week_number: @week_number, created_at: Time.current.beginning_of_year..Time.current.end_of_year
    ).page(params[:page])
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