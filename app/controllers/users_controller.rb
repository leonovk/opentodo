class UsersController < ApplicationController
  include Notifications
  include MainHandling
  before_action :require_no_signed_in, only: [:new, :create]
  before_action :require_signed?, only: [:edit, :update]


  def new
    @user = User.new
  end

  def edit
    if params['id'].to_i != current_user.id
      redirect_to root_path
    end
  end

  def update
    if params['old_password'] == ''
      user = User.find_by(id: current_user.id )
      if user.update(login: login_trimer(params['login']), name: params['name'])
        redirect_to root_path
        message('success')
      else
        redirect_to root_path
        message('Произошла какая то ошибка!')
      end
    else
      user = User.find_by id: current_user.id
      if user.authenticate(params[:old_password]) and valid_password?(params['password'])
        if user.update(login: params['login'], name: params['name'], password: params['password'], password_confirmation: params['password_confirmation'])
          redirect_to root_path
          message('success')
        else
          redirect_to root_path
          message('Произошла какая то ошибка!')
        end
      else
        redirect_to root_path
        message('error')
      end
    end
  end
  

  def create
    @user = User.new user_params
    @user.login = login_trimer(@user.login)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:class] = "alert alert-success alert-dismissible fade show"
      flash[:text] = "Добро пожаловать, #{@user.name}!"
    else
      message('error')
      redirect_to new_user_path
    end
  end


  private
  def user_params
    params.require(:user).permit(:login, :name, :password, :password_confirmation)
  end
end
