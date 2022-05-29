class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  has_many :recorders
  has_many :tasks
  has_many :rooms, through: :recorders
  validates :login, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :name, length: { maximum: 50 }

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    update_column :remember_token_digest, digest(remember_token)  
  end
  def forget_me
    update_column :remember_token_digest, nil
    self.remember_token = nil
  end

  def remember_token_authenticated?(remember_token)
    return false unless remember_token_digest.present?
    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  private
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
