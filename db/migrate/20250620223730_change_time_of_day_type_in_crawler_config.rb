class ChangeTimeOfDayTypeInCrawlerConfig < ActiveRecord::Migration[7.1]
  def change
    change_column :crawler_configs, :time_of_day, :integer, using: 'time_of_day::integer'
  end
end
