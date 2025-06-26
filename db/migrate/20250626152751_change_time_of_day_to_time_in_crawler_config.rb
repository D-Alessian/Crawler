class ChangeTimeOfDayToTimeInCrawlerConfig < ActiveRecord::Migration[7.1]
  def change
    remove_column :crawler_configs, :time_of_day, :integer
    add_column :crawler_configs, :time_of_day, :time, null: false, default: '09:00'
  end
end
