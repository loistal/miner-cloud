class AddStageToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :stage, :integer
  end
end
