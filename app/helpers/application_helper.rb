module ApplicationHelper
  def currently_at(page = '', numberlink)
    case page
    when 'Главная'
      if numberlink == 1
        'nav-link active'
      else
        'nav-link'
      end
    when 'Комнаты'
      if numberlink == 2
        'nav-link active'
      else
        'nav-link'
      end
    when 'Регистрация'
      if numberlink == 3
        'nav-link active'
      else
        'nav-link'
      end
    when 'Войти'
      if numberlink == 4
        'nav-link active'
      else
        'nav-link'
      end
    else
      'nav-link'
    end
  end

  def full_title(page_title = '')
    base_title = 'OpenTodo'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end
end
