class RenameStartDateInWebsites < ActiveRecord::Migration[7.1]
  def change
    rename_column :websites, :startDate, :start_date
  end
end
