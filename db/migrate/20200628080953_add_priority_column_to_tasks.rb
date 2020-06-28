class AddPriorityColumnToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :priority, :integer, default: 0, null: false
    add_index :tasks, :priority
  end
end
