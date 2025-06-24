module Crawler
  class Processor
    TYPES = %i[projects jobs news linkedin].freeze

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
          if website.public_send(digest_attr) != fetched[:digest]
            update_section(website, section, fetched)
          end
        end
      end

    private

    def self.update_section(website, section, fetched)
      url_attr    = "#{section}Page"
      digest_attr = "#{section}Digest"
      body_attr   = "#{section}Body"

      puts "   → updating #{section} for #{website.url}"
      website.update!(
        digest_attr => fetched[:digest],
        body_attr   => fetched[:body],
        :last_change => Time.zone.now
      )
    end
  end
end
