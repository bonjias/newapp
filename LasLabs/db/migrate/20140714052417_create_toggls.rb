class CreateToggls < ActiveRecord::Migration
  def change
    create_table :toggls do |t|

      t.timestamps
    end
  end
end
