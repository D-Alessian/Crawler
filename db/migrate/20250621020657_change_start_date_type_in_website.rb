class ChangeStartDateTypeInWebsite < ActiveRecord::Migration[7.1]
  def change
    change_column :websites, :start_date, :date
  end
end
