class CreateCheckPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :check_points do |t|
      t.integer :user_id
      t.integer :road_id
      t.string :name
      t.text :introduction
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
