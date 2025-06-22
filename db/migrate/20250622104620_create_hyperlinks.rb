class CreateHyperlinks < ActiveRecord::Migration[7.1]
  def change
    create_table :hyperlinks do |t|
      t.string :url
      t.references :website, null: false, foreign_key: true

      t.timestamps
    end
  end
end
