class Task < ApplicationRecord  
  belongs_to :user
  belongs_to :room ,optional: true
  validates :title, presence: true
  after_create_commit { broadcast_append_to(:tasks, partial: "shared/task") }
end
