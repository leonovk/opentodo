module TasksHelper
  def status(room_id, worker)
    unless worker.nil?
      room_id.zero? ? 'В работе' : worker
    end
  end

  def stream_help(room_id)
    room_id == '0' ? "user#{current_user.id}" : "tasks#{room_id}"
  end
end
