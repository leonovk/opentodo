module TasksHelper

  def status(room_id, worker)
    if worker != nil
      if room_id == 0
        status = 'В работе'
      else
        status = worker
      end
    end
  end

  def stream_help(room_id)
    if room_id != '0'
      channel = "tasks#{room_id}"
    else
      channel = "user#{current_user.id}"
    end
  end
  

end