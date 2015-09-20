class AddDateToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :date, :datetime
  end
end
