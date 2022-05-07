class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :status
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
