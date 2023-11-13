class AddLocationNamesToTrip < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :start_address, :string
    add_column :trips, :end_address, :string
  end
end
