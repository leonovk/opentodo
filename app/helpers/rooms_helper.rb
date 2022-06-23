module RoomsHelper

  def delete_or_exit(room_owner_id)
    if room_owner_id != current_user.id
      button = 'Выйти'
    else
      button = 'Удалить'
    end  
  end

  def members(room_id)
    users = Room.find_by(id: room_id).users
    b = []
    i = 1
    for user in users do
      b << user.name
      if i < users.size
        b << ', '
      end
      i += 1
    end
    return b.join('')
  end

  def word_trim(str, len = 35)
    if str != nil
      fragment = /.{#{len}}/
      str = str.split(/(\s+)/).map! { |word|
        (/\s/ === word) ? word : word.gsub(fragment, '\0 ')
      }.join
    end
  end
  
  
end