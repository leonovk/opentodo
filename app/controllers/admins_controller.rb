class AdminsController < ApplicationController
  before_action :admin_rights

  def index
    @users = User.left_outer_joins(:tasks).select('users.*, count(tasks.id) as task_count').group('users.id').order('id DESC').page(params[:page]).per(25)
    @rooms = Room.all.size
    @tasks = Task.all.size
  end

  private

  def admin_rights
    redirect_to root_path if !user_signed_in? || (current_user.admin_status == false)
  end
end
