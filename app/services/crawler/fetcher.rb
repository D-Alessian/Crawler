module Crawler
  class Fetcher
    def self.fetch(url)
      body = fetch_body(url)
      return { body: nil, digest: nil } unless body

      sha256 = Digest::SHA256.hexdigest(body)
      { body: body, digest: sha256 }
    end

    private

    def self.fetch_body(url)
      begin
        return URI.parse(url).read
      rescue StandardError => e
        puts "Error fetching #{url}: #{e.message}"
        nil
      end
    end
  end
end
