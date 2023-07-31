class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def index
    @users = User.all.page(params[:page])
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User updated successfully.'
      redirect_to users_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :department_id, :group_id, :role)
  end
end
