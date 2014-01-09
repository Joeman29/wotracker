class ChangeSegmentsToDefaultValue < ActiveRecord::Migration
  def change
    change_column :completed_segments, :sets, :integer, default: 0
    change_column :segments, :sets, :integer, default: 0
  end
end