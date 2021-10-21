class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      
      t.integer :user_id, foreign_key: true
      t.string :image_id, null: false
      t.string :title, null: false
      t.text :text, null: false
      t.datetime :start_time

      t.timestamps
    end
  end
end
