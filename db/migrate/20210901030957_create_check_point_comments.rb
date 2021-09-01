class CreateCheckPointComments < ActiveRecord::Migration[5.2]
  def change
    create_table :check_point_comments do |t|
      t.integer :user_id
      t.integer :check_point_id
      t.text :body

      t.timestamps
    end
  end
end
