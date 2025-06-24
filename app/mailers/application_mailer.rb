class ApplicationMailer < ActionMailer::Base
  default from: CrawlerConfig.sender_email
  layout 'mailer'
end
