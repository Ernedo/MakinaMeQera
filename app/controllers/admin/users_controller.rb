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
    @user = User.new
  end
  def edit
  end
  def create
    # Rails.logger.info "Params: #{user_params}"
    @user = User.new(user_params)
    # @user.assign_attributes( user_id: current_user.id )
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path }
      else
        format.html { redirect_to admin_new_user_path, notice: "#{@user.errors.messages.map {|k,v| "#{k} #{v.first}"}.first}"}
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
