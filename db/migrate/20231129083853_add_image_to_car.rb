class AddImageToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :image_url, :string, null: true
    add_column :vehicles, :car_weight, :integer, null: false, default: 60
    add_column :vehicles, :default, :boolean, default: false
  end
end
