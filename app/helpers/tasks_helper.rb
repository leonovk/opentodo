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

end