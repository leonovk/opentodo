class RoomsController < ApplicationController
  before_action :authorize_chek
  

  def index
    user = User.find(current_user.id)
    @rooms = user.rooms.order("updated_at DESC").page(params[:page]).per(5)
  end

  def create 
    r = Room.new(title: params['title'], owner_id: current_user.id)
    if r.save
      rec = Recorder.new(room_id: r.id, user_id: current_user.id)
      rec.save
      redirect_to rooms_path
      flash[:class] = "alert alert-success"
      flash[:text] = 'Комната успешно создана!'
    else
      redirect_to rooms_path
      flash[:class] = "alert alert-danger"
      flash[:text] = 'Ошибка!'
    end
  end

  def edit
    @room = Room.find_by id: params['id']
    room_rights(params['id'])
  end

  def update
    room_rights(params['id'])
    @room = Room.find_by id: params['id']
    if @room.update(title: params['title'], description: params['description'])
      redirect_to "/rooms/#{params['id']}"
    end  
  end
  
  
  def show
    @room = Room.find(params['id'])
    user = @room.users.find_by(id: current_user.id)
    if user.present?
      @tasks = @room.tasks.order("id")
      @users = @room.users
    else
      redirect_to root_path
    end
  end
  
  def add ## and remove
    user = User.find_by(login: params['login'])
    room = Room.find(params['id'])
    if current_user.id == room.owner_id and user.present?
      if params['add'].present? and !room.users.where(id: user.id).present?
        rec = Recorder.new(room_id: params['id'], user_id: user.id)
        rec.save
        redirect_to "/rooms/#{params['id']}"
      end
      if params['remove'].present?
        rec = Recorder.where(room_id: room.id, user_id: user.id)
        rec.each do |r|
          r.destroy
        end
        redirect_to "/rooms/#{params['id']}"
      end
      flash[:class] = "alert alert-success"
      flash[:text] = 'Успех!'
    else
      flash[:class] = "alert alert-danger"
      flash[:text] = 'Ошибка!'
      redirect_to "/rooms/#{params['id']}"
    end
  end

  def destroy
    room = Room.find(params['id'])
      if current_user.id == room.owner_id     
        rec = Recorder.where(room_id: room.id)
        rec.each do |r|
          r.destroy
        end
        room.destroy
        redirect_to rooms_path
      else
        rec = Recorder.where(room_id: room.id, user_id: current_user.id)
        rec.each do |r|
          r.destroy
        end
        redirect_to rooms_path
      end
  end

  private
  def authorize_chek
    if !user_signed_in?
      redirect_to root_path
    end
  end

  def room_rights(room_id)
    room = Room.find(room_id)
    if room.owner_id != current_user.id
      flash[:class] = "alert alert-danger"
      flash[:text] = 'Ошибка!'
      redirect_to "/rooms/#{room_id}"
    end    
  end

end
