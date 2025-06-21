class CrawlerConfig < ApplicationRecord
  # Class-level helper that grabs the value from the first row
  def self.sender_email
    first&.sender_email
  end
end


