class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :name
      t.integer :rest_time, default: 60
      t.integer :workout_id
      t.integer :position
      t.integer :sets, default: 1
      t.timestamps
    end
    add_index :segments, :workout_id
  end
end
