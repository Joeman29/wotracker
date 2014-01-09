class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name, default: 'New Exercise'
      t.text :descript
      t.string :kind, default: 'Weight Lifting'
      t.integer :reps, default: 5
      t.float :time, default: 1
      t.integer :position
      t.float :weight, default: 5
      t.string :weight_unit, default: 'kg'
      t.integer :segment_id
      t.timestamps
    end
    add_index :exercises, :segment_id
  end
end
