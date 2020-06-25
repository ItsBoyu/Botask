class AddStartAndEndAtColumnsInTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :start_at, :datetime, null: false
    add_column :tasks, :end_at, :datetime, null: false
  end
end
