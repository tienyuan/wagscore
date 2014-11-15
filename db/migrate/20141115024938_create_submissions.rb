class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :ip_address
      t.string :email
      t.references :location

      t.timestamps
    end

    add_index :submissions, :location_id
  end
end
