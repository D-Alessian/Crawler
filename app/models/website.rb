class Website < ApplicationRecord
  has_many :key_actors, dependent: :destroy
  has_many :hyperlinks, dependent: :destroy

  accepts_nested_attributes_for :key_actors, allow_destroy: true
  accepts_nested_attributes_for :hyperlinks, allow_destroy: true

  scope :changed_today, -> { where(updated_at: Time.zone.today.all_day) }

  def self.import_from_csv(path)
    new_importer = WebsiteImporter.run(path)
  end
end
