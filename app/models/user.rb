class User < ApplicationRecord
  has_secure_password
  has_many :recorders
  has_many :rooms, through: :recorders
  validates :login, presence: true, uniqueness: true
end
