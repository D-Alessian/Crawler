module Crawler
  class Processor

    def self.compare_all
      Project.includes(:websites).all.each do |project|
        is_project_changed = false
        puts "Evaluating #{project.name}"
        project.websites.each do |site|
          next unless site.url.present?

          fetched = Fetcher.fetch(site.url)
          next unless fetched && fetched[:body].present?
          if site.digest != fetched[:digest]
            update_site(site, site.website_type, fetched)
            is_project_changed = true
          end
        end
        change_project(project) if is_project_changed
      end
    end

    private

    def self.update_site(site, type, fetched)
      puts "   → updating #{type.to_sym} for #{site.project.name}"
      site.update!(
        digest: fetched[:digest],
        body: fetched[:body],
        last_change: Date.today
      )
    end

    def self.change_project(project)
      project.update!(last_change: Time.zone.now)
    end

    def self.first_seed_all
      Project.all.each do |project|
        unless project.is_seeded?
          puts "Seeding #{project.name} with new body and digest"
          project.websites.each do |site|
            next unless site.url.present?

            fetched = Fetcher.fetch(site.url)
            next unless fetched && fetched[:body].present?

            site.update!(
              digest: fetched[:digest],
              body: fetched[:body]
            )
            project.update!(is_seeded: true)
          end
        end
      end
    end

    def self.first_seed(project)
      puts "Seeding #{project.name} with new body and digest"
      project.websites.each do |site|
        next unless site.url.present?

        fetched = Fetcher.fetch(site.url)
        next unless fetched && fetched[:body].present?

        site.update!(
          digest: fetched[:digest],
          body: fetched[:body]
        )
        project.update!(is_seeded: true)
      end
    end

  end
end