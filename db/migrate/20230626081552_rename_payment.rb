class RenamePayment < ActiveRecord::Migration[7.0]
  def change
    rename_column :passengers, :payment, :payment_method
  end
end
