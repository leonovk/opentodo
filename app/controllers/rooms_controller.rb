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
    else
      redirect_to root_path
    end
  end

  private
  def authorize_chek
    if !user_signed_in?
      redirect_to root_path
    end
  end
end
