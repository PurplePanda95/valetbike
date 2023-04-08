class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :distance

      t.timestamps
    end
  end
end
