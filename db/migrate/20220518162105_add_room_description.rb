class AddRoomDescription < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :description, :string
  end
end
