# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    skip_before_action :check_login
    before_action :find_user, only: %i[show edit update destroy]
    before_action :build_user, only: %i[new create]

    def index
      @users = User.includes(:tasks)
    end

    def new; end

    def create
      @user.assign_attributes(user_params)

      if @user.save
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit(:email,
                                   :password,
                                   :password_confirmation,
                                   :name)
    end

    def find_user
      @user = User.find(params[:id])
    end

    def build_user
      @user = User.new
    end
  end
end
