class AddQbNameToInvoices < ActiveRecord::Migration
  def up
    add_column :invoices, :qb_name, :string, limit:20
    add_index :invoices, :qb_name
  end
  def down
    remove_index :invoices, :qb_name
    remove_column :invoices, :qb_name
  end   
end
