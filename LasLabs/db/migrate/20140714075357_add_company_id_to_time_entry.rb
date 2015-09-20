class AddCompanyIdToTimeEntry < ActiveRecord::Migration
  def change
    add_column :time_entries, :company_id, :integer
  end
end
