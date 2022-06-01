class Room < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :recorders, dependent: :destroy
  has_many :users, through: :recorders
  validates :title, presence: true
end
