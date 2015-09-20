class FixCboColsInUsers < ActiveRecord::Migration
  def up
    remove_column :users, :enc_qbo_realm_id
    add_column :users, :enc_qbo_company_id, :string
    add_column :users, :qbo_token_exp, :datetime
    add_column :users, :qbo_reconnect_tok, :datetime
  end
  def down
    add_column :users, :enc_qbo_realm_id, :string
    remove_column :users, :qbo_token_exp
    remove_column :users, :enc_qbo_company_id
    remove_column :users, :qbo_reconnect_tok
  end
end
