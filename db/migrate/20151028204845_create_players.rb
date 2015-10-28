class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.column :name, :string
      t.column :rating, :integer

      t.timestamps
    end
  end
end
