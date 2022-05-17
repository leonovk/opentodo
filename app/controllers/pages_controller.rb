class PagesController < ApplicationController
  def index
    if user_signed_in?
      @tasks = Task.where(user_id: current_user.id)
    end
  end
end