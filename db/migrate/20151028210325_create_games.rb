class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.column :notation, :string

      t.timestamps
    end
  end
end
