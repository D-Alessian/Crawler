class CrawlerConfig < ApplicationRecord
  after_commit :reschedule_cron

  def self.sender_email
    first&.sender_email
  end

  def cron_expression
    hour = time_of_day.hour
    "0 #{hour} */#{regularity_days} * *"
  end

  private

  def reschedule_cron
    Sidekiq::Cron::Job.create(
      name: 'Daily crawler',
      cron: cron_expression,
      class: 'CrawlDailyJob',
      overwrite: true
    )
  end
end


