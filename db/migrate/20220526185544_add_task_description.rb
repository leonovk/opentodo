class AddTaskDescription < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :description, :string
  end
end
