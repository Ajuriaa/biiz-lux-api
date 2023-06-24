class CreateDriverTable < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.references :user, foreign_key: true
      t.integer :score, default: 5
      t.string :license
      t.date :license_expiration_date

      t.timestamps
    end
  end
end
