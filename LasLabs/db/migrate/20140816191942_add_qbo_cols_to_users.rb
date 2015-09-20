class AddQboColsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :enc_qbo_token, :string
    add_column :users, :enc_qbo_secret, :string
    add_column :users, :enc_qbo_realm_id, :string
  end
  def down
    remove_column :users, :enc_qbo_token
    remove_column :users, :enc_qbo_secret
    remove_column :users, :enc_qbo_realm_id
  end
end
