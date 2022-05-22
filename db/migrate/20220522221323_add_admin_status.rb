class AddAdminStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin_status, :boolean, default: 0
  end
end
