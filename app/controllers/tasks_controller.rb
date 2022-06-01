class TasksController < ApplicationController
  include Notifications
  include Rights
  before_action :room_determinant
  

  def create
    task = Task.new(title: params['task'], status: 0, user_id: current_user.id, room_id: @room_id)
    if task.save
      if params['id'] != nil
        redirect_to room_path
        room = Room.find_by(id: params['id']).update(updated_at: Time.now)      
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
      message('error')
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
      if task.room_id != 0
        redirect_to "/rooms/#{task.room_id}"
      else
        redirect_to root_path
      end    
    end
    
  end
  

  def status
    if params['id'] != '0'
      return false unless room_rights_write(current_user.id, params['id'])
    end
    parameters = []
    not_include = ['authenticity_token', 'get', 'controller', 'action', 'id']
    params.each do |k, v|
      if !not_include.include? k
        parameters << k
      end
    end
    for id in parameters do
      task = Task.find(id)
      if params['get'] == '1'
        task.destroy 
      elsif params['get'] == '2'  
        if task.status == true
          task.update(status: '0') 
        else
          task.update(status: '1') 
        end
      else
        message('error')
      end
    end
    if params['id'] != '0'
      redirect_to "/rooms/#{params['id']}"
    else
      redirect_to root_path
    end
  end
  

  private
  def room_determinant
    if params['id'] == nil
      @room_id = 0
    else
      @room_id = params['id']
    end
  end

  def task_rights(task_id)
    task = Task.find(task_id)
    if user_signed_in?
      if task.room_id == 0
        if task.user_id != current_user.id
          redirect_to root_path
        end
      else
        rec = Recorder.find_by(user_id: current_user.id, room_id: task.room_id)
        if !rec.present?
          redirect_to root_path
        end
      end
    else
      redirect_to root_path  
    end 
  end
  
end