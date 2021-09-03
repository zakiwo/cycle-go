class AddCategoryToCheckPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :check_points, :category, :integer
  end
end
