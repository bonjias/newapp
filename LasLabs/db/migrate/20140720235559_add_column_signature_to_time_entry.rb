class AddColumnSignatureToTimeEntry < ActiveRecord::Migration
  def up
    add_column :time_entries, :signature, :string
    add_index :time_entries, :signature
  end
  def down
    remove_index :time_entries, :signature
    remove_column :time_entries, :signature
end
end
