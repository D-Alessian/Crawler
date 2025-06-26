class CrawlerMailerController < ApplicationController
  def daily_report
    @projects = Project.changed_today
    authorize @projects
  end
end
