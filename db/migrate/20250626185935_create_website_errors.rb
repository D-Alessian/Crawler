class CreateWebsiteErrors < ActiveRecord::Migration[7.1]
  def change
    create_table :website_errors do |t|
      t.references :website, null: false, foreign_key: true
      t.string :message
      t.date :date

      t.timestamps
    end
  end
end
