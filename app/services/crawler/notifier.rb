module Crawler
  class Notifier

    def main
      Processor.compare_all
      CrawlerMailer.daily_report.deliver_now
    end
  end
end
