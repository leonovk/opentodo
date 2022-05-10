class Room < ApplicationRecord

  has_many :users, through: :recorders
  has_many :recorders


  validates :title, presence: true
end
