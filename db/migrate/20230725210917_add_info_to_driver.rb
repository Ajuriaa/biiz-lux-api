class AddInfoToDriver < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :experience, :integer
    add_column :drivers, :bilingual, :boolean
  end
end
