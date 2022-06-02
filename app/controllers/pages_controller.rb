class PagesController < ApplicationController
  def index
    if user_signed_in?
      @tasks = Task.where(user_id: current_user.id, room_id: 0).order("id")
    end
  end
end