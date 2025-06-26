class ChangeTypeInWebsitesToWebsiteType < ActiveRecord::Migration[7.1]
  def change
    rename_column :websites, :type, :website_type
  end
end
