class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.integer :price_per_person_per_night
      t.integer :owner_id

      t.timestamps
    end
  end
end
