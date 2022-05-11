class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :rooms, :user_id, :owner_id
  end
end
