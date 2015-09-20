class ChangeAdminToBool < ActiveRecord::Migration
  def change
    change_column :authorized_users, :admin, :bool
  end
end
