class CreateNewWebsites < ActiveRecord::Migration[7.1]
  def change
    create_table :websites do |t|
      t.string :url
      t.integer :type
      t.date :last_change
      t.text :body
      t.string :digest
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
