class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title 
      t.text :lesson
      t.integer :user_id
      t.integer :difficulty 
      t.string :language
      t.timestamps
    end
  end
end
