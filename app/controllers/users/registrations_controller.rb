class Users::RegistrationsController < ApplicationController
  before_action :build_user, only: %i[new create]

  def new; end

  def create
    @user.assign_attributes(user_params)

    if @user.save
      session[:current_user_id] = @user.id
      redirect_to root_path, notice: t('user.created')
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 :name)
  end

  def build_user
    @user = User.new
  end
end
