class AddUserableToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :userable, polymorphic: true, index: true
  end
end
