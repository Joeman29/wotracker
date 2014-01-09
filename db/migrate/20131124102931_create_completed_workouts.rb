class CreateCompletedWorkouts < ActiveRecord::Migration
  def change
    create_table :completed_workouts do |t|
      t.string :name
      t.text :descript
      t.float :time
      t.date :date
      t.integer :rating, default: 0
      t.integer :user_id
      t.float :goal_time
      t.timestamps
    end
    add_index :completed_workouts, :user_id
  end
end
