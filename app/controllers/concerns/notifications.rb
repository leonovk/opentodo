module Notifications
  extend ActiveSupport::Concern

  included do
    def message(string)
      if string == 'error'
        flash[:class] = "alert alert-danger alert-dismissible fade show"
        flash[:text] = 'Ошибка! Вы что то делаете неправильно, попробуйте еще раз!'
      elsif string == 'success'
        flash[:class] = "alert alert-success alert-dismissible fade show"
        flash[:text] = 'Успешно!'
      else
        flash[:class] = "alert alert-warning alert-dismissible fade show"
        flash[:text] = string
      end
    end
  end
end