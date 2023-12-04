class AddEventsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.json :location_coordinates, null: false
      t.string :address_name, null: false
      t.string :category, null: false
      t.string :description, null: false

      t.timestamps
    end
    add_reference :trips, :event, foreign_key: true
  end
end
