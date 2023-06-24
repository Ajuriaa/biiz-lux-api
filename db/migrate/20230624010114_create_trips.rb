class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.json :start_location
      t.json :end_location
      t.datetime :start_time
      t.datetime :end_time
      t.float :distance
      t.decimal :fare
      t.string :status

      t.timestamps
    end
  end
end
