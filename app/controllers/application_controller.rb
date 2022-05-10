class ApplicationController < ActionController::Base
  private
  def current_user
    if session[:user_id].present?
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :current_user, :user_signed_in?
end
