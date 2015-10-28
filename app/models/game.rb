class Game < ActiveRecord::Base
  validates :notation, presence: true
  has_many :matches
  has_many :players, through: :matches
end
