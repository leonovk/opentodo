module MainHandling
  extend ActiveSupport::Concern

  included do
    def require_no_signed_in
      if user_signed_in?
        flash[:class] = "alert alert-warning alert-dismissible fade show"
        flash[:text] = 'Вы уже авторизованы!'
        redirect_to root_path
      end
    end
  
    def require_signed?
      if user_signed_in?
        true
      else
        redirect_to root_path
      end
    end

    def authorize_chek
      unless user_signed_in?
        redirect_to root_path
      end
    end
    
  
    def remember(user)
      user.remember_me
      cookies.encrypted.permanent[:remember_token] = user.remember_token
      cookies.encrypted.permanent[:user_id] = user.id
    end
  
    def forget(user)
      user.forget_me
      cookies.delete :user_id
      cookies.delete :remember_token
    end
  
    def have_room?
      @room.present?
    end

    def login_trimer(login)
      l = login.gsub(' ','')
    end
    
    def valid_password?(password)
      if password.size >= 6
        true
      else
        false
      end
    end
    

  end
end