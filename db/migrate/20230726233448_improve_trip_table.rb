class ImproveTripTable < ActiveRecord::Migration[7.0]
  def change
    change_column_default :trips, :status, 'active'
    change_column :trips, :fare, :float
  end
end
