class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :start
      t.datetime :end
      t.decimal :total, precision: 7, scale: 2
      t.integer :company

      t.timestamps
    end
  end
end
