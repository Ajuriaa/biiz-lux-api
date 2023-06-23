class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :role, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
