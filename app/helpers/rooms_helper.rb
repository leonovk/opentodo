module RoomsHelper

  def delete_or_exit(room_owner_id)
    if room_owner_id != current_user.id
      button = 'Выйти'
    else
      button = 'Удалить'
    end  
  end
  
end