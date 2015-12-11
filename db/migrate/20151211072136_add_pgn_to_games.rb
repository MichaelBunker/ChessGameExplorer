class AddPgnToGames < ActiveRecord::Migration
  def change
    add_column :games, :pgn, :string
  end
end
