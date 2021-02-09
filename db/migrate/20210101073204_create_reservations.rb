class CreateReservations < ActiveRecord::Migration[6.0]
  create_table :reservations do |t|
    t.integer :reserving_user_id
    t.integer :reserved_room_id

    t.timestamps
  end
  add_index :reservations, :reserving_user_id
  add_index :reservations, :reserved_room_id
  add_index :reservations, [:reserving_user_id, :reserved_room_id], unique: true
end

