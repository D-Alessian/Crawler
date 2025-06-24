set :output, "log/cron.log"
env :PATH, ENV["PATH"]

every CrawlerConfig.first_or_initialize.regularity_days.day,
      at: "#{CrawlerConfig.first_or_initialize.time_of_day}:00 am" do
  rake 'crawl:run'
end