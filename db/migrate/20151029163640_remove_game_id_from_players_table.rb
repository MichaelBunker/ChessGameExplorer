class RemoveGameIdFromPlayersTable < ActiveRecord::Migration
  def change
    remove_column :players, :game_id
    remove_column :games, :player_id
  end
end
