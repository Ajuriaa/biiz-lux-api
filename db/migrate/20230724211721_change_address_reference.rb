class ChangeAddressReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :addresses, :user, index: true
    add_reference :addresses, :passenger, null: false, foreign_key: true
  end
end
