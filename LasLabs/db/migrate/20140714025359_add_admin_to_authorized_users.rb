class AddAdminToAuthorizedUsers < ActiveRecord::Migration
  def up
    add_column :authorized_users, :admin, :string
  end

  def down
    remove_column :authorized_users, :admin
  end
end
