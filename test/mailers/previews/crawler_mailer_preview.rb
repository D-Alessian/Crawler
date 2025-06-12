# Preview all emails at http://localhost:3000/rails/mailers/crawler_mailer
class CrawlerMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/crawler_mailer/daily_report
  def daily_report
    CrawlerMailer.daily_report
  end
end
