class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by login: params[:login]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end