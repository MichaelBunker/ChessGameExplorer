class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end
