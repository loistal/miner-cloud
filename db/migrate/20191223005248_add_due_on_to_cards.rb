class AddDueOnToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :due_on, :date
  end
end
