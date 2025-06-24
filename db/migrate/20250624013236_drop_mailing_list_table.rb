class DropMailingListTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :mailing_lists
  end
end
