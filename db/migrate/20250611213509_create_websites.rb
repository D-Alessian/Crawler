class CreateWebsites < ActiveRecord::Migration[7.1]
  def change
    create_table :websites do |t|
      t.string :url
      t.text :body
      t.string :digest
      t.datetime :last_change

      t.timestamps
    end
  end
end
