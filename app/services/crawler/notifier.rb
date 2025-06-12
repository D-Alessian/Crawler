module Crawler
  class Notifier

    def self.main
      puts "Comparing all websites"
      Processor.compare_all
      puts "Delivering e-mail"
      CrawlerMailer.daily_report.deliver_now
    end
  end
end
