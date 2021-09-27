class CreateWaypoints < ActiveRecord::Migration[5.2]
  def change
    create_table :waypoints do |t|
      t.integer :road_id
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.integer :point_no

      t.timestamps
    end
  end
end
