class NormalizeProjects < ActiveRecord::Migration[7.1]
  def up
    Project.find_each do |project|
      # mapping of project columns => website_type enum
      {
        projects:    [:projectsPage,    :projectsBody,    :projectsDigest,    :projects_last_change],
        jobs:        [:jobsPage,        :jobsBody,        :jobsDigest,        :jobs_last_change],
        news:        [:newsPage,        :newsBody,        :newsDigest,        :news_last_change],
        linkedin:    [:linkedinPage,    :linkedinBody,    :linkedinDigest,    :linkedin_last_change],
      }.each do |type, (url_col, body_col, digest_col, last_change_col)|
        url   = project.send(url_col)
        next if url.blank?

        project.websites.create!(
          project:      project,
          website_type: Website.website_types[type],
          url:          url,
          body:         project.send(body_col),
          digest:       project.send(digest_col),
          last_change:  project.send(last_change_col)
        )
      end
    end
  end

  def down
    # reverse: scoop websites back into project columns (optional; you can leave this empty if you don't plan to rollback)
    Project.find_each do |project|
      project.websites.each do |site|
        case site.website_type.to_sym
        when :projects
          project.update_columns(
            projectsPage:        site.url,
            projectsBody:        site.body,
            projectsDigest:      site.digest,
            projects_last_change: site.last_change
          )
        when :jobs
          project.update_columns(
            jobsPage:            site.url,
            jobsBody:            site.body,
            jobsDigest:          site.digest,
            jobs_last_change:    site.last_change
          )
        when :news
          project.update_columns(
            newsPage:            site.url,
            newsBody:            site.body,
            newsDigest:          site.digest,
            news_last_change:    site.last_change
          )
        when :linkedin
          project.update_columns(
            linkedinPage:        site.url,
            linkedinBody:        site.body,
            linkedinDigest:      site.digest,
            linkedin_last_change: site.last_change
          )
        end
      end
      project.websites.where(website_type: site.website_type).delete_all
    end
  end
end

