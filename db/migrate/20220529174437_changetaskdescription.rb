class Changetaskdescription < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :description
    add_column :tasks, :description, :text
  end
end
