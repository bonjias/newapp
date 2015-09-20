class AddTogglIdToCompanies < ActiveRecord::Migration
  def up
    add_column :companies, :toggl_id, :integer
    add_column :companies, :qb_client_id, :integer
  end
  def down
    remove_column :companies, :toggl_id
    remove_column :companies, :qb_client_id
  end
end
