class ChangeProjectsTypesAndNames < ActiveRecord::Migration[7.1]
  def change
    rename_column :projects, :start_date, :date_started_tracking
    rename_column :projects, :member, :is_member
    rename_column :projects, :seeded, :is_seeded

    change_column :projects, :is_seeded, :boolean, default: false
    change_column_default :projects, :date_started_tracking, from: nil, to: -> { 'CURRENT_DATE' }
  end
end
