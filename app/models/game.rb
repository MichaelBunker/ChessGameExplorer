class Game < ActiveRecord::Base
  validates :notation, presence: true
end
