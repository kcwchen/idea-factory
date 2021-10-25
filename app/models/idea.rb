class Idea < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 20 }
end
