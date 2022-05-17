class TasksController < ApplicationController
  before_action :room_determinant

  def create
    task = Task.new(title: params['task'], status: 0, user_id: current_user.id, room_id: @room_id)
    if task.save
      if params['id'] != nil
        redirect_to current_room_path
      else
        redirect_to root_path
      end
    else
      redirect_to "/rooms"
    end
  end

  def destroy
    task = Task.find(params['id'])
    task.destroy
    redirect_to current_room_path
  end

  private
  def room_determinant
    if params['id'] == nil
      @room_id = 0
    else
      @room_id = params['id']
    end
  end
end