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

  def status
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
        flash[:class] = "alert alert-danger"
        flash[:text] = 'Ошибка!'
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
end