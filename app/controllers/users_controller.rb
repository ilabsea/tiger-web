class UsersController < ApplicationController
  add_breadcrumb 'Users', :users_path, only: [:new, :edit]

  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @users = User.all_except(current_user)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    add_breadcrumb 'Edit user'
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if (user_params[:password].blank? && @user.update_without_password(user_params)) || user.update(user_params)
      redirect_to users_path, notice: "Successfully updated User."
    else
      flash.now[:alert] = 'Failed to update users'
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Successfully created User.'
    else
      flash.now[:alert] = 'Failed to save user'
      render 'new'
    end
  end

  def new
    add_breadcrumb 'New user'
    @user = User.new
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: "Successfully deleted User."
    else
      redirect_to users_path, alert: "Failed to deleted User."
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
