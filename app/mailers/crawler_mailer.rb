class CrawlerMailer < ApplicationMailer
  default from: CrawlerConfig.sender_email
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.crawler_mailer.daily_report.subject
  #
  def daily_report(projects = Project.changed_today)
      @projects = projects
      mail(to: User.where(role: [2, 3, 4]).pluck(:email), subject: 'Daily Crawling Report, Projects Changed: ' + @projects.count.to_s)
  end
end
