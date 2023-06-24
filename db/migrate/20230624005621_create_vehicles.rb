class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.references :driver, null: false, foreign_key: true
      t.string :vehicle_type
      t.string :model
      t.string :plate
      t.integer :year
      t.string :color
      t.string :registration
      t.date :registration_expiration_date

      t.timestamps
    end
  end
end
