module RoomsHelper
  def delete_or_exit(room_owner_id)
    room_owner_id == current_user.id ? 'Удалить' : 'Выйти'
  end

  def members(users)
    return nil if users.size <= 1
    
    b = []
    i = 1
    users.each do |user|
      b << user.name
      b << ', ' if i < users.size
      i += 1
    end
    "Участники: #{b.join('')}"
  end

  def word_trim(str, len = 10)
    unless str.nil?
      fragment = /.{#{len}}/
      str = str.split(/(\s+)/).map! do |word|
        /\s/ === word ? word : word.gsub(fragment, '\0&shy;')
      end.join
    end
  end

  def admin_room(room_owner_id, user_id)
    return '- админ' if room_owner_id == user_id
  end
  
end
