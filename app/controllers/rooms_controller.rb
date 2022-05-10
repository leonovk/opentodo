class RoomsController < ApplicationController

  def index
    if user_signed_in?
      user = User.find(current_user.id)
      @roomsid = @user.rooms
    else
      redirect_to root_path
    end
  end

  def create
    if user_signed_in?
      rooms = Room.new(title: params['title'], user_id: current_user.id)
      if rooms.save
        recorder = Recorder.new(room_id: rooms.id, user_id: current_user.id)
        if recorder.save
          redirect_to rooms_path
        else
          redirect_to root_path
        end
      end
    else
      redirect_to root_path
    end
  end
  
end
