class TasksController < ApplicationController
  before_action :room_determinant
  before_action :authorize_chek

  def create
    return false unless room_rights_write(current_user.id, params['id'])

    task = Task.new(title: params['task'], user_id: current_user.id, room_id: @room_id)
    room = Room.find_by(id: params['id'])
    room.update(updated_at: Time.now) if !params['id'].nil? and room.present?
    if task.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:tasks, partial: 'shared/task', locals: { task: })
        end
        if params['id'].nil?
          format.html { redirect_to root_path }
        else
          format.html { redirect_to "/rooms/#{task.room_id}" }
        end
      end
    end
  end

  def edit
    task_rights(params['id'])
    @task = Task.find_by id: params['id']
  end

  def update
    task_rights(params['id'])
    task = Task.find_by id: params['id']
    if task.update(title: params['title'], description: params['description'])
      if task.room_id == 0
        redirect_to root_path
      else
        redirect_to "/rooms/#{task.room_id}"
      end
    end
  end

  def status
    return false unless room_rights_write(current_user.id, params['id'])
    return false if params['task'].nil?

    parameters = []
    params['task'].each do |k, _v|
      parameters << k
    end
    parameters.each do |id|
      task = Task.find(id)
      case params['get']
      when '1'
        task.destroy
      when '2'
        if task.worker == current_user.name
          task.update(worker: nil)
        else
          task.update(worker: current_user.name)
        end
      else
        message('error')
      end
    end
    if params['id'] == '0'
      redirect_to root_path
    else
      Room.find_by(id: params['id']).update(updated_at: Time.now)
      redirect_to "/rooms/#{params['id']}"
    end
  end

  private

  def room_determinant
    if params['id'].nil?
      @room_id = 0
    else
      chek_room = Room.find_by(id: params['id'])
      @room_id = chek_room.present? ? params['id'] : 0
    end
  end

  def task_rights(task_id)
    task = Task.find(task_id)
    if user_signed_in?
      if task.room_id.zero?
        redirect_to root_path if task.user_id != current_user.id
      else
        rec = Recorder.find_by(user_id: current_user.id, room_id: task.room_id)
        redirect_to root_path unless rec.present?
      end
    else
      redirect_to root_path
    end
  end
end
