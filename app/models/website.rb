class Website < ApplicationRecord
  belongs_to :project

  scope :changed_today, -> { where(last_change: Date.today) }

  enum website_type: { projects: 1, jobs: 2, news: 3, linkedin: 4 }
end
