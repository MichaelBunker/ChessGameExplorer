class Pgn < ActiveRecord::Base
  validates :pgn, presence: true
  mount_uploader :pgn, PgnUploader

end
