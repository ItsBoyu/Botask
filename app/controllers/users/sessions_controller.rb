class Users::SessionsController < ApplicationController
  skip_before_action :check_login

  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(user_params[:email])

    if user.present? && user.authenticate(user_params[:password])
      session[:current_user_id] = user.id
      redirect_to root_path, notice: t('user.loggedin')
    else
      redirect_to users_log_in_path
    end
  end

  def destroy
  end

  def user_params
    params.require(:user).permit(:email,
                                 :password)
  end
end
