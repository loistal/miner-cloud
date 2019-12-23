class RemoveStageFromCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :stage, :string
  end
end
