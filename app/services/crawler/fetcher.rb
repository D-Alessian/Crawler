module Crawler
  class Fetcher
    def self.fetch(website_column)
      fetch_result = fetch_body(website_column.url)
      body = fetch_result[:body]
      errors = fetch_result[:errors]

      website_column.website_errors.create!(message: errors, date: Date.today) if errors
      return { body: nil, digest: nil } if body.nil?

      clean_body = Parser.clean_html(body)

      sha256 = Digest::SHA256.hexdigest(clean_body)
      { body: body, digest: sha256, clean_body: clean_body }
    end

    private

    def self.fetch_body(url)
      begin
        { body: URI.parse(url).read, errors: nil }
      rescue StandardError => e
        puts "Error fetching #{url}: #{e.message}"
        { body: nil, errors: e.message }
      end
    end
  end
end
