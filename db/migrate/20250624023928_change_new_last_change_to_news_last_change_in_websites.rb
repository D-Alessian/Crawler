class ChangeNewLastChangeToNewsLastChangeInWebsites < ActiveRecord::Migration[7.1]
  def change
    rename_column :websites, :new_last_change, :news_last_change
  end
end
