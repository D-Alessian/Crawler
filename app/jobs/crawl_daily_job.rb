class CrawlDailyJob 
    include Sidekiq::Worker

    def perform
        Crawler::Processor.compare_all
    end
end