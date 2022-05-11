class RoomsController < ApplicationController

  def index
    if user_signed_in?
      user = User.find(current_user.id)
      @rooms = user.rooms
    else
      redirect_to root_path
    end
  end

  def create
    if user_signed_in?
      r = Room.new(title: params['title'], owner_id: current_user.id)
      if r.save
        rec = Recorder.new(room_id: r.id, user_id: current_user.id)
        rec.save
        redirect_to rooms_path
      else
        redirect_to root_path
      end
    end
  end
  
  def show
    
  end
end
