class ChangeWorkerTaskStatus < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :status
    add_column :tasks, :worker, :string
  end
end
