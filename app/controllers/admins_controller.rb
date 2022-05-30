class AdminsController < ApplicationController
  before_action :admin_rights
 
  def index
    @users = User.all.order("id DESC").page(params[:page]).per(25)
  end
 
  private
  def admin_rights
    if user_signed_in?
      if current_user.admin_status == false
        redirect_to root_path
      end
    else
      redirect_to root_path
    end   
  end
end