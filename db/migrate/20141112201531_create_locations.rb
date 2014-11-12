class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.boolean :public, default: false
      t.boolean :flagged, default: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
