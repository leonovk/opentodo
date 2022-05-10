class User < ApplicationRecord
  has_secure_password

  has_many :rooms, through: :recorders
  has_many :recorders



  validates :login, presence: true, uniqueness: true
end
