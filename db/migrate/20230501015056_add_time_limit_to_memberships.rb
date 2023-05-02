class AddTimeLimitToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :time_limit, :integer
  end
end
