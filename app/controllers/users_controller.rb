class UsersController < Devise::RegistrationsController

  before_action :authenticate_user!
  # load_and_authorize_resource
  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update_profile
    @user = User.find_by(id: current_user.id)
    respond_to do |format|
      if @user.update_with_password(user_params)
        format.html { redirect_to user_path }
      else
        format.html { render :edit}
      end
    end
  end

  def show
    @user = User.find_by(id: current_user.id)
  end


 private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :password, :password_confirmation, :current_password)
  end

end
