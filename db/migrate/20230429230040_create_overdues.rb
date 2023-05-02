class CreateOverdues < ActiveRecord::Migration[7.0]
  def change
    create_table :overdues do |t|
      t.integer :user_id
      t.integer :time_over

      t.timestamps
    end
  end
end
