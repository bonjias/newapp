class AddUniqueToSignature < ActiveRecord::Migration
  def up
#    remove_index :time_entries, :signature
    add_index :time_entries, :signature, {unique:true}
  end
  def down
    remove_index :time_entries, :signature
  end
end
