class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.datetime :start
      t.datetime :end
      t.integer :rate
      t.text :description
      t.string :tags
      t.integer :invoice
      t.integer :user

      t.timestamps
    end
  end
end
