class ChangeQboEncsToText < ActiveRecord::Migration
  def up
    change_column :users, :enc_qbo_token, :text
    change_column :users, :enc_qbo_secret, :text
    change_column :users, :enc_qbo_company_id, :text
  end
  def down
    change_column :users, :enc_qbo_token, :string
    change_column :users, :enc_qbo_secret, :string
    change_column :users, :enc_qbo_company_id, :string
  end
end
