class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :longitude
      t.string :latitude
      t.boolean :primary
      t.string :address

      t.timestamps
    end
  end
end
