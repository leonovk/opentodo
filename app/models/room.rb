class Room < ApplicationRecord

  has_many :recorders
  has_many :users, through: :recorders


  validates :title, presence: true
end
