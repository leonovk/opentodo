module TasksHelper
  def status(room_id, worker)
    unless worker.nil?
      if room_id.zero?
        'В работе'
      else
        worker
      end
    end
  end

  def stream_help(room_id)
    room_id == '0' ? "user#{current_user.id}" : "tasks#{room_id}"
  end
end
