class AddCompanyIdToUsers < ActiveRecord::Migration
  def up
    add_column :users, :company_id, :integer
  end
  def down
    remove_columd :users, :company_id
  end
end
