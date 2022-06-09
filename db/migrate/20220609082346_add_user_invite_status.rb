class AddUserInviteStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :invite_status, :boolean, default: 0
  end
end
