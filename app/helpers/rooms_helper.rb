module RoomsHelper
  def delete_or_exit(room_owner_id)
    room_owner_id == current_user.id ? 'Удалить' : 'Выйти'
  end

  def members(room_id)
    users = Room.find_by(id: room_id).users
    b = []
    i = 1
    users.each do |user|
      b << user.name
      b << ', ' if i < users.size
      i += 1
    end
    b.join('')
  end

  def word_trim(str, len = 10)
    unless str.nil?
      fragment = /.{#{len}}/
      str = str.split(/(\s+)/).map! do |word|
        /\s/ === word ? word : word.gsub(fragment, '\0&shy;')
      end.join
    end
  end
end
