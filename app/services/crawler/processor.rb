module Crawler
  class Processor

    HTML_ATTRS_TO_IGNORE = %w[script style link[rel="stylesheet"] noscript iframe header footer nav]

    # Compare all projects and their websites, updating the digest and body if changes are detected
    # This is the main method that will be called to process all projects
    def self.compare_all
      start_time = Time.now
      Project.includes(:websites).all.each do |project|
        is_project_changed = false
        puts "Evaluating #{project.name}"
        project.websites.each do |site|
          next unless site.url.present?

          fetched = Fetcher.fetch(site)
          next unless fetched && fetched[:body].present?

          if site.digest != fetched[:digest]
            process_diff(site, fetched) if site.clean_body.present?
            update_site(site, site.website_type, fetched)
            is_project_changed = true
          end
        end
        change_project(project) if is_project_changed
      end
      puts "Comparison completed in #{(Time.now - start_time).round(2)} seconds"
    end

    # Seed all projects with new body and digest without adding a date
    # This is useful for initial seeding to make sure it doesn't get included in website that "changed today"
    # It will only seed projects that have not been seeded yet. It is meant to be run when you add projects in bulk.
    def self.first_seed_all
      Project.all.each do |project|
        unless project.is_seeded?
          puts "Seeding #{project.name} with new body and digest"
          project.websites.each do |site|
            next unless site.url.present?

            fetched = Fetcher.fetch(site)
            next unless fetched && fetched[:body].present?

            update_site_without_date(site, fetched)
            project.update!(is_seeded: true)
          end
        end
      end
    end

    # Seed a specific project with new body and digest without adding a date
    # This is useful for initial seeding to make sure it doesn't get included in website that "changed today"
    def self.first_seed(project)
      puts "Seeding #{project.name} with new body and digest"
      project.websites.each do |site|
        next unless site.url.present?

        fetched = Fetcher.fetch(site)
        next unless fetched && fetched[:body].present?

        update_site_without_date(site, fetched)
        project.update!(is_seeded: true)
      end
    end

    private

    def self.update_site(site, type, fetched)
      puts "   → updating #{type.to_sym} for #{site.project.name}"
      site.update!(
        digest: fetched[:digest],
        body: fetched[:body],
        clean_body: fetched[:clean_body],
        last_change: Date.today
      )
    end

    def self.update_site_without_date(site, fetched)
      site.update!(
        digest: fetched[:digest],
        body: fetched[:body],
        clean_body: fetched[:clean_body]
      )
    end

    # Update the last change timestamp for a project
    # This is used to mark when a project was last updated

    def self.change_project(project)
      project.update!(last_change: Time.zone.now)
    end

    # Process the diff between the old and new clean bodies
    def self.process_diff(site, fetched)
      diff = ""
      old_clean = site.clean_body.lines
      new_clean = fetched[:clean_body].lines
      patches = Diff::LCS.sdiff(old_clean, new_clean)

      changes = patches.select do |change|
        change.action != '='
      end

      changes.each do |change|
        case change.action
        when '+'
          diff += "+ #{change.new_element.strip}\n"
        when '-'
          diff += "- #{change.old_element.strip}\n"
        when '!'
          diff += "- #{change.old_element.strip}\n+ #{change.new_element.strip}\n"
        end
      end

      site.update!(diff: diff)
    end

  end
end