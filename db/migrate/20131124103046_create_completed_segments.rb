class CreateCompletedSegments < ActiveRecord::Migration
  def change
    create_table :completed_segments do |t|
      t.string :name
      t.integer :time
      t.integer :position
      t.integer :completed_workout_id
      t.integer :sets
      t.integer :rest_time
      t.timestamps
    end
    add_index :completed_segments, :completed_workout_id
  end
end
