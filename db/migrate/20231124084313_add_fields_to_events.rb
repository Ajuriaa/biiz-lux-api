class AddFieldsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :image_url, :string, null: true
    add_column :events, :passcorde, :string, null: true
  end
end
