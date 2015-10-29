class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :rating, presence: true

  has_and_belongs_to_many :games
end
