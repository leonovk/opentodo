class RoomsController < ApplicationController

  def index
    if user_signed_in?
      @rooms = Room.all
      @test_var = 1
    else
      redirect_to root_path
    end
  end
  
end
