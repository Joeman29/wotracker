class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name, default: 'New Workout'
      t.text :descript
      t.integer :goal_time, default: 30
      t.integer :user_id
      t.timestamps
    end
    add_index :workouts, :user_id
  end
end
