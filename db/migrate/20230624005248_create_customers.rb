class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :score
      t.string :payment

      t.timestamps
    end
  end
end
