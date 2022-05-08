class Task < ApplicationRecord
  belongs_to :room
  validates :title, presence: true
end
