class CrawlerMailerController < ApplicationController
  def daily_report
    @projects = Project.changed_today
    @errored_websites = Website.errored_today
    authorize @projects
  end
end
