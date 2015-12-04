class Game < ActiveRecord::Base
  validates :notation, presence: true
  has_and_belongs_to_many :players
end
