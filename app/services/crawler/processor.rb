module Crawler
  class Processor
    def self.compare_all
      Website.all.each do |website|
        puts "Evaluating #{website.url}"
        new_data = Fetcher.fetch(website.url)
        puts new_data[:digest]
        unless same_sha?(website, new_data)
          update_website(website, new_data)
        end
      end
    end

    private

    def self.update_website(website, new_data)
      puts "updating #{website.url}"
      new_attributes = {
        body:        new_data[:body],
        digest:      new_data[:digest],
        last_change: Time.zone.now
      }
      website.update!(new_attributes)
    end

    def self.same_sha?(old_website, new_website)
      old_website.digest == new_website[:digest]
    end
  end
end
