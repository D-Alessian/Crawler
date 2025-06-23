class RemoveUrlFromWebsites < ActiveRecord::Migration[7.1]
  def change
    remove_column :websites, :url, :string
    remove_column :websites, :body, :text
    remove_column :websites, :digest, :string
  end
end
