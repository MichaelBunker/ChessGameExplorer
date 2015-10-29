class Add < ActiveRecord::Migration
  def change
    add_column :players, :game_id, :integer
    add_column :games, :player_id, :integer
  end
end
