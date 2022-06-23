class Task < ApplicationRecord  
  belongs_to :user
  belongs_to :room ,optional: true
  validates :title, presence: true
  after_create_commit :broadcast
  private
  def broadcast
    if room_id != 0
      channel = "tasks#{room_id}"
    else
      channel = "user#{user_id}"
    end
    broadcast_append_to(channel, partial: "shared/task")
  end
end
