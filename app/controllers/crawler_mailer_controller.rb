class CrawlerMailerController < ApplicationController
  def daily_report
    @websites = Website.changed_today
    authorize @websites
  end
end
