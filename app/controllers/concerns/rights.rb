module Rights
  extend ActiveSupport::Concern

  included do
    def rooms_rights_owner(user_id, room_id)
      user = User.find(user_id)
      room = Room.find(room_id)
      user.id == room.owner_id
    end

    def inviteble?(user_id)
      user = User.find_by(id: user_id)
      user.invite_status != true
    end

    def room_rights_write(user_id, room_id)
      if room_id != '0' and !room_id.nil?
        room = Room.find_by(id: room_id)
        return false unless room.present?

        if room.users.find_by(id: user_id).present?
          true
        else
          false
        end
      else
        true
      end
    end

    def room_rights(room_id)
      room = Room.find(room_id)
      redirect_to "/rooms/#{room_id}" if room.owner_id != current_user.id
    end
  end
end
