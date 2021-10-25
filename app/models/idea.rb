class Idea < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 20 }
end
