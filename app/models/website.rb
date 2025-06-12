class Website < ApplicationRecord
  scope :changed_today, -> { where(updated_at: Time.zone.today.all_day) }
end
