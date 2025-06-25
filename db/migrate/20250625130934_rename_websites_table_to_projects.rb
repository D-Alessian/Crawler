class RenameWebsitesTableToProjects < ActiveRecord::Migration[7.1]
  def change
    rename_table :websites, :projects
    rename_column :key_actors, :website_id, :project_id
    rename_column :hyperlinks, :website_id, :project_id
  end
end
