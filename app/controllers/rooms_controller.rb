class RoomsController < ApplicationController
  before_action :authorize_chek

  def index
    user = User.find(current_user.id)
    @rooms = user.rooms
  end

  def create 
    r = Room.new(title: params['title'], owner_id: current_user.id)
    if r.save
      rec = Recorder.new(room_id: r.id, user_id: current_user.id)
      rec.save
      redirect_to rooms_path
    else
      redirect_to root_path
    end
  end
  
  def show
    @room = Room.find(params['id'])
    user = @room.users.find_by(id: current_user.id)
    if user.present?
      @tasks = @room.tasks
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
    else
      redirect_to root_path
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
end
