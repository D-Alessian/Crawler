class DailyCrawlJob < ApplicationJob
  queue_as :default

  def perform
    Notifier.main
  end
end
