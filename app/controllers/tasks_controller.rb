class TasksController < ApplicationController

  def create
    task = Task.new(title: params['task'], status: 0, user_id: current_user.id, room_id: params['id'])
    if task.save
      redirect_to current_room_path
    else
      redirect_to root_path
    end
  end

  def destroy
    task = Task.find(params['id'])
    task.destroy
    redirect_to current_room_path
  end

end