class Website < ApplicationRecord
  has_many :key_actors, dependent: :destroy
  scope :changed_today, -> { where(updated_at: Time.zone.today.all_day) }
end
