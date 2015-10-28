class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.belongs_to :player, index: true
      t.belongs_to :game, index: true
      t.timestamps
    end
  end
end
