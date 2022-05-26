class Task < ApplicationRecord  
  belongs_to :user
  belongs_to :room ,optional: true
  validates :title, presence: true
end
