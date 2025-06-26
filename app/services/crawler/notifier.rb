module Crawler
  class Notifier

    def self.main
      puts "Delivering e-mail"
      CrawlerMailer.daily_report.deliver_now
    end
  end
end
