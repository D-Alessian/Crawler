class AddSeededToWebsites < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :seeded, :boolean
  end
end
