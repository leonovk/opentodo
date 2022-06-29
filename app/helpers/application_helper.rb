module ApplicationHelper
  def currently_at(page = '', numbers)
    case page
    when 'Главная'
      numbers == 1 ? 'nav-link active' : 'nav-link'
    when 'Комнаты'
      numbers == 2 ? 'nav-link active' : 'nav-link'
    when 'Регистрация'
      numbers == 3 ? 'nav-link active' : 'nav-link'
    when 'Войти'
      numbers == 4 ? 'nav-link active' : 'nav-link'
    else
      'nav-link'
    end
  end

  def drop_active(page)
    if page == 'Профиль'
      'nav-link dropdown-toggle active'
    else
      'nav-link dropdown-toggle'
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
