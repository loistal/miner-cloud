class AddTranslationToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :translation, :string
  end
end
