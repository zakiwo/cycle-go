class AddAreaToRoads < ActiveRecord::Migration[5.2]
  def change
    add_column :roads, :area, :integer
  end
end
