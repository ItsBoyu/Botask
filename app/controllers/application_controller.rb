# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :check_login

  private

  def check_login
    redirect_to users_log_in_path unless current_user
  end

  def current_user
    User.find_by(id: session[:current_user_id])
  end

  def record_not_found
    render file: 'public/404.html',
           status: 404,
           layout: false
  end
end
