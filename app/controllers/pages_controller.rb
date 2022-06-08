class PagesController < ApplicationController
  def index
    @tasks = Task.where(user_id: current_user.id, room_id: 0).order("id") if user_signed_in?
  end
end
