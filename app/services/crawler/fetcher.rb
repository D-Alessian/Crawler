module Crawler
  class Fetcher
    def self.fetch(url)
      body = fetch_body(url)
      return [nil, nil] unless body

      sha256 = Digest::SHA256.hexdigest(body)
      { body: body, digest: sha256 }
    end

    private

    def fetch_body(url)
      URI.parse(url).read
    end
  end
end
