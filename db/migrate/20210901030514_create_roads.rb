class CreateRoads < ActiveRecord::Migration[5.2]
  def change
    create_table :roads do |t|
      t.integer :user_id
      t.string :name
      t.text :introduction
      t.float :start_latitude
      t.float :start_longitude
      t.float :goal_latitude
      t.float :goal_longitude
      t.integer :distance
      t.integer :elevation_gain
      t.integer :difficulty
      t.boolean :is_editable

      t.timestamps
    end
  end
end
