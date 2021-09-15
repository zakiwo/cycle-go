class AddRoadidsToCheckPointComments < ActiveRecord::Migration[5.2]
  def change
    add_column :check_point_comments, :road_id, :integer
  end
end
