class CrawlerMailer < ApplicationMailer
  def daily_report(websites = Website.changed_today)
      @websites = websites
      mail(to: User.where(role: [2, 3, 4]).pluck(:email), subject: 'Daily Crawling Report, Websites Changed: ' + @websites.count.to_s)
  end
end
