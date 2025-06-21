class CrawlerConfig < ApplicationRecord
  # Always give me “the one row”
  class << self
    def current = first_or_create!

    delegate :sender_email,
             :time_of_day,
            :regularity_days,
  end
end

