class CrawlerMailer < ApplicationMailer
  default from: CrawlerConfig.sender_email
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.crawler_mailer.daily_report.subject
  #
  def daily_report(sites = Website.changed_today)
      @sites = sites
      mail(to: MailingList.pluck(:email), subject: 'Daily Crawling Report, Websites Changed: ' + @sites.count.to_s)
  end
end
