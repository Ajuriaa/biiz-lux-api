class ChangeUserIdNullableInPassengers < ActiveRecord::Migration[7.0]
  def change
    change_column :passengers, :user_id, :bigint, null: true
    change_column :admins, :user_id, :bigint, null: true
  end
end
