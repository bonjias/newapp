
class TimeEntryRenameUserToUserId < ActiveRecord::Migration
  def change
    rename_column :time_entries, :user, :user_id
  end
end
