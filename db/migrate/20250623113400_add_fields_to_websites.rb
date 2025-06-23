class AddFieldsToWebsites < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :member, :boolean
    add_column :websites, :projectsPage, :string
    add_column :websites, :jobsPage, :string
    add_column :websites, :newsPage, :string
    add_column :websites, :linkedinPage, :string
  end
end
