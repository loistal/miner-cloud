class AddWordsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :words, :text
  end
end
