module RoomsHelper

  def delete_or_exit(room_owner_id)
    room_owner_id != current_user.id ? 'Выйти' : 'Удалить'
  end

  def members(room_id)
    users = Room.find_by(id: room_id).users
    b = []
    i = 1
    users.each { |user|
      b << user.name
      if i < users.size
        b << ', '
      end
      i += 1
    }
    b.join('')
  end

  def word_trim(str, len = 35)
    unless str.nil?
      fragment = /.{#{len}}/
      str = str.split(/(\s+)/).map! { |word|
        /\s/ === word ? word : word.gsub(fragment, '\0 ')
      }.join
    end
  end
  
end