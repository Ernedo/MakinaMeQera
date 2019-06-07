class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @users = User.where(deleted_at: nil)
  end
  def show
  end
  def new
    @users = User.new
  end
  def edit
  end
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        UserMailer.with(user: @user).welcome_email.deliver_later
        format.html { redirect_to @user, notice: 'User was created' }
      else
        format.html { render :new }
      end
    end
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was update' }
      else
        format.html { render :edit }
      end
    end
  end
  def destroy
    Rails.logger.info "*****params: #{params}"
    @user.update(deleted_at: Time.now)
    respond_to do |format|
      format.html { redirect_to admin_user_url, notice: 'User was destroy' }
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
