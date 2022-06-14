module Rights
  extend ActiveSupport::Concern


  included do
    def rooms_rights_owner(user_id, room_id)
      user = User.find(user_id)
      room = Room.find(room_id)
      if user.id == room.owner_id
        true
      else
        false
      end
    end

    def inviteble?(user_id)
      user = User.find_by(id: user_id)
      if user.invite_status == true
        false
      else
        true
      end
    end

    def room_rights_write(user_id, room_id)
      room = Room.find_by(id: room_id)
      if room.users.find_by(id: user_id).present?
        true
      else
        false
      end   
    end
    
    def room_rights(room_id)
      room = Room.find(room_id)
      if room.owner_id != current_user.id
        redirect_to "/rooms/#{room_id}"
      end    
    end
  
  end
end