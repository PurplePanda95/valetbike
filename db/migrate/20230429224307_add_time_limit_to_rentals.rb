class AddTimeLimitToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :time_limit, :integer
  end
end
