class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by login: params[:login]
    if user&.authenticate(params[:password])
      remember(user) if params[:remember_me] == '1'
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    forget current_user
    session.delete :user_id
    redirect_to root_path
  end
end