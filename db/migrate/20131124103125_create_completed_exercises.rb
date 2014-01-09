class CreateCompletedExercises < ActiveRecord::Migration
  def change
    create_table :completed_exercises do |t|
      t.string :name
      t.string :kind
      t.float :time
      t.string :timeset, array:true
      t.integer :position
      t.integer :completed_segment_id
      t.float :weight
      t.string :weight_unit
      t.integer :reps
      t.text :descript
      t.timestamps
    end
    add_index :completed_exercises, :completed_segment_id
  end
end
