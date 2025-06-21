class CreateKeyActors < ActiveRecord::Migration[7.1]
  def change
    create_table :key_actors do |t|
      t.string :name
      t.references :website, null: false, foreign_key: true

      t.timestamps
    end
  end
end
