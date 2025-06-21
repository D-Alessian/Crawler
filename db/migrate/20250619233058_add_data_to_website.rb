class AddDataToWebsite < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :country, :string
    add_column :websites, :type, :string
    add_column :websites, :size, :string
    add_column :websites, :name, :string
    add_column :websites, :status, :string
    add_column :websites, :start_date, :datetime
  end
end
