class Recorder < ApplicationRecord
  belongs_to :room
  has_many :rooms, through: :users
end
