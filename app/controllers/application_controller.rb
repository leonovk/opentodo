class ApplicationController < ActionController::Base
  private
  def current_user
    if session[:user_id].present?
      @current_user = User.find_by(id: session[:user_id])
    elsif cookies.encrypted[:user_id].present?
      user = User.find_by(id: cookies.encrypted[:user_id])
      if user&.remember_token_authenticated?(cookies.encrypted[:remember_token])
        session[:user_id] = user.id
        @current_user = User.find_by(id: session[:user_id])
      end
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def remember(user)
    user.remember_me
    cookies.encrypted.permanent[:remember_token] = user.remember_token
    cookies.encrypted.permanent[:user_id] = user.id
  end

  def forget(user)
    user.forget_me
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def have_room?
    @room.present?
  end

  helper_method :current_user, :user_signed_in?, :have_room?
end
