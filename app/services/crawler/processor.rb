module Crawler
  class Processor
    SECTIONS = %i[projects jobs news linkedin].freeze

    def self.compare_all
      Website.all.each do |website|
        puts "Evaluating #{website.name}"
        SECTIONS.each do |section|
          url_attr    = "#{section}Page"
          digest_attr = "#{section}Digest"
          body_attr   = "#{section}Body"

          url = website.public_send(url_attr)
          next unless url.present?

          fetched = Fetcher.fetch(url)
          next unless fetched && fetched[:body].present?
          
          if website.public_send(digest_attr) != fetched[:digest]
            update_section(website, section, fetched)
          end
        end
      end
    end

    private

    def self.update_section(website, section, fetched)
      url_attr    = "#{section}Page"
      digest_attr = "#{section}Digest"
      body_attr   = "#{section}Body"
      date_attr  = "#{section}_last_change"

      puts "   → updating #{section} for #{website.name}"
      website.update!(
        digest_attr => fetched[:digest],
        body_attr   => fetched[:body],
        :last_change => Time.zone.now,
        date_attr => Time.zone.now
      )
    end

    def self.first_seed_all
      Website.all.each do |website|
        unless website.seeded?
          puts "Seeding #{website.name} with new body and digest"
          SECTIONS.each do |section|
            url_attr    = "#{section}Page"
            digest_attr = "#{section}Digest"
            body_attr   = "#{section}Body"

            url = website.public_send(url_attr)
            next unless url.present?

            fetched = Fetcher.fetch(url)
            next unless fetched && fetched[:body].present?

            website.update!(
              digest_attr => fetched[:digest],
              body_attr   => fetched[:body],
              seeded: true,
            )
          end
        end
      end
    end

    def self.first_seed(website)
      puts "Seeding #{website.name} with new body and digest"
      SECTIONS.each do |section|
        url_attr    = "#{section}Page"
        digest_attr = "#{section}Digest"
        body_attr   = "#{section}Body"

        url = website.public_send(url_attr)
        next unless url.present?

        fetched = Fetcher.fetch(url)
        next unless fetched && fetched[:body].present?

        website.update!(
          digest_attr => fetched[:digest],
          body_attr   => fetched[:body],
          seeded: true,
        )
      end
    end

  end
end
