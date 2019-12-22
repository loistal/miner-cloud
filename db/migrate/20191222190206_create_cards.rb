class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :stage
      t.string :source   
      t.integer :timesreviewed  
      t.integer :timessuccess
      t.integer :timesfailed  
      t.timestamps
    end
  end
end
