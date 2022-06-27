class SessionsController < ApplicationController
  before_action :require_no_signed_in, only: :new
  before_action :require_signed?, only: :destroy

  def new; end

  def create
    user = User.find_by login: params[:login]
    if user&.authenticate(params[:password])
      remember(user) if params[:remember_me] == '1'
      session[:user_id] = user.id
      redirect_to root_path
    else
      message('Ошибка авторизации! Возможно вы ввели невереный пароль!')
      redirect_to new_session_path
    end
  end

  def destroy
    forget current_user
    session.delete :user_id
    redirect_to root_path, status: :see_other
  end
end
