class Website < ApplicationRecord
  belongs_to :project
  has_many :website_errors, dependent: :destroy

  scope :changed_today, -> { where(last_change: Date.today) }
  scope :errored_today, -> { joins(:website_errors).merge(WebsiteError.errored_today) }

  enum website_type: { projects: 1, jobs: 2, news: 3, linkedin: 4 }
end
