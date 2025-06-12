module Crawler
  class Processor
    def self.compare_all
      Website.all.each do |website|
        new_data = Fetcher.fetch(website.url)
        if same_sha?(website, new_data[:digest])
          update_website(website, new_data)
        end
      end
    end

    private

    def update_website(website, new_data)
      website.body = new_data[:body]
      website.digest = new_data[:digest]
      website.last_change = DateTime.now
      website.save
    end

    def self.same_sha?(old_website, new_website)
      old_website.digest == new_website[:digest]
    end
  end
end
