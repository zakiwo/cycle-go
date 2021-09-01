class CreateRoadComments < ActiveRecord::Migration[5.2]
  def change
    create_table :road_comments do |t|
      t.integer :user_id
      t.integer :road_id
      t.text :body

      t.timestamps
    end
  end
end
