class CreateAuthorizedUsers < ActiveRecord::Migration
  def change
    create_table :authorized_users do |t|
      t.string :email
      t.integer :company

      t.timestamps
    end
  end
end
