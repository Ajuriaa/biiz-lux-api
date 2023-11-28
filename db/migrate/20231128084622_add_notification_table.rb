class AddNotificationTable < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :image_url, null: false
      t.string :description, null: false
      t.datetime :due_date, null: false

      t.timestamps
    end
  end
end
