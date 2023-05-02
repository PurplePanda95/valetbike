class AddDescriptionToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :description, :string
  end
end
