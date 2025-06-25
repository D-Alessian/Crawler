class RemoveObsoleteColumnsFromProjects < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :website_type, :string

    remove_column :projects, :projectsPage, :string
    remove_column :projects, :projectsBody, :text
    remove_column :projects, :projectsDigest, :string
    remove_column :projects, :projects_last_change, :datetime

    remove_column :projects, :jobsPage, :string
    remove_column :projects, :jobsBody, :text
    remove_column :projects, :jobsDigest, :string
    remove_column :projects, :jobs_last_change, :datetime

    remove_column :projects, :newsPage, :string
    remove_column :projects, :newsBody, :text
    remove_column :projects, :newsDigest, :string
    remove_column :projects, :news_last_change, :datetime

    remove_column :projects, :linkedinPage, :string
    remove_column :projects, :linkedinBody, :text
    remove_column :projects, :linkedinDigest, :string
    remove_column :projects, :linkedin_last_change, :datetime
  end
end
