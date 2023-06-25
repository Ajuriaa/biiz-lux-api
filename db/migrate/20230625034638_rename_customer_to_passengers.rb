class RenameCustomerToPassengers < ActiveRecord::Migration[7.0]
  def change
    rename_table :customers, :passengers
    rename_column :trips, :customer_id, :passenger_id
  end
end
