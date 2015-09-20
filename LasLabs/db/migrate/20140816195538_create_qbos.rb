class CreateQbos < ActiveRecord::Migration
  def change
    create_table :qbos do |t|

      t.timestamps
    end
  end
end
