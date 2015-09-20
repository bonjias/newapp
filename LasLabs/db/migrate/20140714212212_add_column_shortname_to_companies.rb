class AddColumnShortnameToCompanies < ActiveRecord::Migration
  def up
    add_column :companies, :shortname, :string, limit: 5
    add_index :companies, :shortname
  end

  def down
    remove_index :companies, :shortname
    remove_column :companies, :shortname
  end
end
