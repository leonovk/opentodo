module TasksHelper

  def status(task_id)
    task = Task.find_by(id: task_id)
    if task.worker != nil
      if task.room_id == 0
        status = 'В работе'
      else
        room = Room.find_by(id: task.room_id)
        if room.users.size > 1
          status = task.worker
        else
          status = 'В работе'
        end
      end
    end
  end

end