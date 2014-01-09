class ExercisesController < ApplicationController
  include Authenticating
  respond_to :json
  def list
  end

  def show
    @exercise = Exercise.find(params[:id])
    respond_with @exercise
  end
  def index
    @exercises = Exercise.where(segment_id: params[:segment_id]).take()
    respond_with @exercises
  end
  def new
  end

  def create
    @exercise =  Exercise.new(exercise_params)
    @exercise.segment_id = params[:segment_id]
    @exercise.save!
    redirect_to action: 'show', id: @exercise.id
    #render :nothing => true
  end

  def edit
  end

  def update
    @exercise = Exercise.find(params[:id])
    @exercise.update(exercise_params)
    respond_with @exercise
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    render :nothing => true
  end
  private
  def exercise_params
    params.require(:exercise).permit(:name, :kind, :reps,:position,:sets, :weight, :weight_unit,:descript, :time, :position, :segment_id )
  end
end
