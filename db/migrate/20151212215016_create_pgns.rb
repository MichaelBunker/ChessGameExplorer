class CreatePgns < ActiveRecord::Migration
  def change
    create_table :pgns do |t|
      t.column :pgn, :string

      t.timestamps
    end
  end
end
