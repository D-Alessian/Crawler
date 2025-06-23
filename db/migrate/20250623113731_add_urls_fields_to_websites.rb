class AddUrlsFieldsToWebsites < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :projectsBody, :text
    add_column :websites, :jobsBody, :text
    add_column :websites, :newsBody, :text
    add_column :websites, :linkedinBody, :text
    add_column :websites, :projectsDigest, :string
    add_column :websites, :jobsDigest, :string
    add_column :websites, :newsDigest, :string
    add_column :websites, :linkedinDigest, :string
  end
end
