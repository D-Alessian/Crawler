class Project < ApplicationRecord
  has_many :key_actors, dependent: :destroy
  has_many :hyperlinks, dependent: :destroy
  has_many :websites, dependent: :destroy

  accepts_nested_attributes_for :key_actors, allow_destroy: true
  accepts_nested_attributes_for :hyperlinks, allow_destroy: true
  accepts_nested_attributes_for :websites, allow_destroy: true, reject_if: ->(attrs) { attrs['url'].blank? }

  scope :changed_today, -> { where(last_change: Time.zone.today.all_day) }

  def self.import_from_csv(path)
    new_importer = ProjectImporter.run(path)
  end
end
