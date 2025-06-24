class AddLinkTimestampsToWebsites < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :projects_last_change, :datetime
    add_column :websites, :jobs_last_change, :datetime
    add_column :websites, :new_last_change, :datetime
    add_column :websites, :linkedin_last_change, :datetime
  end
end
