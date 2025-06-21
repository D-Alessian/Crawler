set :output, "log/cron.log"
env :PATH, ENV["PATH"]

every CrawlerConfig.first_or_initialize.regularity_days.day,
      at: "0#{CrawlerConfig.first_or_initialize.time_of_day}" do
  rake 'crawl:run'
end