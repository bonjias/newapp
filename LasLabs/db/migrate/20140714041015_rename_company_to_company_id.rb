class RenameCompanyToCompanyId < ActiveRecord::Migration
  def change
    rename_column :invoices, :company, :company_id
  end
end
