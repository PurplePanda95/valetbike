class AddRenterIdToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column(:rentals, :renter_id, :integer, index: true)
  end
end
