class AddColumnsToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :start_date, :date, null: false 
    add_column :reservations, :end_date, :date, null: false 
    add_column :reservations, :number_of_people, :integer, null: false 
  end
end
