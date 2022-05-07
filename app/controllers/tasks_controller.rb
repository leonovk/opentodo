class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new(title: params["task"], status: 0)
    if @task.save
      redirect_to tasks_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @task = Task.find_by id: params[:id]
    @task.destroy
    redirect_to tasks_path
  end


end