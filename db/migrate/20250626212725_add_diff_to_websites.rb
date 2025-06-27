class AddDiffToWebsites < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :diff, :string
    add_column :websites, :clean_body, :text
  end
end
