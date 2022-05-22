class AdminsController < ApplicationController
  before_action :admin_rights
 
  def index
    @users = User.all
  end
 
  private
  def admin_rights
    if current_user.admin_status == false
      redirect_to root_path
    end   
  end
end