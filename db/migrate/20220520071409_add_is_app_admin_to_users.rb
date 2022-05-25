class AddIsAppAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_app_admin, :boolean, default: false
  end
end
