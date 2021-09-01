class CreateRoadFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :road_favorites do |t|
      t.integer :user_id
      t.integer :road_id

      t.timestamps
    end
  end
end
