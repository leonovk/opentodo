module Notifications
  extend ActiveSupport::Concern

  included do
    def message(string)
      if string == 'error'
        flash[:class] = "alert alert-danger"
        flash[:text] = 'Ошибка! Вы что то делаете не правильно, попробуйте еще раз!'
      elsif string == 'success'
        flash[:class] = "alert alert-success"
        flash[:text] = 'Успешно!'
      else
        flash[:class] = "alert alert-warning"
        flash[:text] = string
      end
    end
  end
end