class RoomsController < ApplicationController
  include Notifications
  include MainHandling
  include Rights

  before_action :authorize_chek
  

  def index
    user = User.find(current_user.id)
    @rooms = user.rooms.order("updated_at DESC").page(params[:page]).per(5)
  end

  def create 
    r = Room.new(title: params['title'], owner_id: current_user.id)
    if r.save
      rec = Recorder.new(room_id: r.id, user_id: current_user.id)
      redirect_to rooms_path if rec.save
      message('success')
    else
      redirect_to rooms_path
      message('error')
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
  
  def add ## and remove users in room
    user = User.find_by(login: params['login'])
    room = Room.find(params['id'])
    if rooms_rights_owner(current_user.id, room.id) and user.present?
      if params['add'].present? and !room.users.find_by(id: user.id).present? and inviteble?(user.id)
        rec = Recorder.new(room_id: params['id'], user_id: user.id)
        redirect_to "/rooms/#{params['id']}" if rec.save
        message('success')
      elsif params['remove'].present? and room.users.find_by(id: user.id).present?
        rec = Recorder.find_by(room_id: room.id, user_id: user.id)
        redirect_to "/rooms/#{params['id']}" if rec.destroy
        message('success')
      else
        redirect_to "/rooms/#{params['id']}"
        message('Пользователь запретил, приглашать себя в комнаты')
      end
    else
      message('Ошибка!')
      redirect_to "/rooms/#{params['id']}"
    end
  end

  def destroy
    room = Room.find(params['id'])
      if current_user.id == room.owner_id     
        room.destroy
        redirect_to rooms_path
        message('Комната была удалена!')
      else
        rec = Recorder.find_by(room_id: room.id, user_id: current_user.id)
        rec.destroy
        message('Вы покинули комнату!')
        redirect_to rooms_path
      end
  end

end
