class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :rating, presence: true
  has_many :matches
  has_many :games, through: :matches
end
