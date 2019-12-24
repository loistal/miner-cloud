class AddIconToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :icon, :string
  end
end
