class CrawlerMailer < ApplicationMailer
  
  def daily_report(projects = Project.changed_today)
      @projects = projects
      mail(to: User.where(role: [2, 3, 4]).pluck(:email), subject: 'Daily Crawling Report, Projects Changed: ' + @projects.count.to_s)
  end
end
