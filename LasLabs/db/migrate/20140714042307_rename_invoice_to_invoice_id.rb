class RenameInvoiceToInvoiceId < ActiveRecord::Migration
  def change
    rename_column :time_entries, :invoice, :invoice_id
  end
end
