class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :category_id, index: true
      t.integer :location_id, index: true
      t.timestamps
    end

    add_index :categorizations, :id, unique: true
    add_index :categorizations, :category_id
    add_index :categorizations, :location_id
  end
end
