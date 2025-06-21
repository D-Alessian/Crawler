class CreateCrawlerConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :crawler_configs do |t|
      t.string :time_of_day
      t.integer :regularity_days
      t.string :sender_email

      t.timestamps
    end
  end
end
