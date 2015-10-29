class RenameMatchesToGamesPlayers < ActiveRecord::Migration
  def change
    rename_table :matches, :games_players
  end
end
