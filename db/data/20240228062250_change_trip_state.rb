class ChangeTripState < ActiveRecord::Migration[7.0]
  def change
    Trip.where(status: 'active').update_all(status: 'pending')
  end
end
