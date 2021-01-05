class AddColumnsToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :room_introduction, :text
    add_column :rooms, :address, :string, null: false 

  end
end
