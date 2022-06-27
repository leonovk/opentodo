class Task < ApplicationRecord
  belongs_to :user
  belongs_to :room, optional: true
  validates :title, presence: true
  after_create_commit :broadcast

  private

  def broadcast
    channel = room_id.zero? ? "user#{user_id}" : "tasks#{room_id}"
    broadcast_append_to(channel, partial: 'shared/task')
  end
end
