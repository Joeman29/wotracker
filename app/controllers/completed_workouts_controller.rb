class CompletedWorkoutsController < ApplicationController
  include Authenticating

  def complete
    completedWorkout = CompletedWorkout.new(cw_params)
    completedWorkout.user = current_user
    completedWorkout.date = Date.today
    completedWorkout.save!
    render :nothing => true
  end
  def update
    completedWorkout = CompletedWorkout.find(params[:id])
    completedWorkout.update_attributes(cw_params)
    render :nothing => true
  end
  def cw_params
    exercise_attrs = [:name, :weight, :weight_unit, :time, :position, :reps, :sets, :kind, :descript, :timeset => []]
    segment_attrs = [:name, :time, :position, :sets, :completed_exercises_attributes => exercise_attrs]
    params.require(:workout).permit(:name, :time, :descript, :date, :goal_time, :rating, :completed_segments_attributes => segment_attrs)
  end
end
