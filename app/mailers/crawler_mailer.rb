class CrawlerMailer < ApplicationMailer
  default from: CrawlerConfig.sender_email
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.crawler_mailer.daily_report.subject
  #
  def daily_report(websites = Website.changed_today)
      @websites = websites
      mail(to: User.where(role: [2, 3, 4]).pluck(:email), subject: 'Daily Crawling Report, Websites Changed: ' + @websites.count.to_s)
  end
end
