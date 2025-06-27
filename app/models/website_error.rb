class WebsiteError < ApplicationRecord
  belongs_to :website

  scope :errored_today, -> { where(date: Time.zone.today.all_day) }
end
