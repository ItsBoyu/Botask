# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :check_login

  private

  def check_login
    redirect_to users_log_in_path if not current_user
  end

  def current_user
    User.find_by(id: session[:current_user_id])
  end
end
