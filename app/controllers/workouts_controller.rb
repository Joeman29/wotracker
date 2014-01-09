class WorkoutsController < ApplicationController
  include Authenticating
  respond_to :html, :json
  before_action :get_workout, only: [:show, :edit, :update, :play, :destroy]
  def show
    respond_with @workout
  end
  def index
    @workouts = current_user.workouts
  end
  def new
     @workout = Workout.new
  end
  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user
    if @workout.save
      redirect_to user_workouts_path(current_user)
    else
      render 'new'
    end
  end
  def edit
    respond_with @workout
  end
  def update
    @workout.update(workout_params)
    respond_with(@workout)
  end
  def destroy
    if @workout.destroy
      flash[:notice] = 'Workout deleted successfully.'
    end
    redirect_to user_workouts_path(current_user)
  end
  def play
    puts "#{@workout.name} id:#{@workout.id}"
  end
  private
  def get_workout
    @workout = Workout.find(params[:id])
  end
  def workout_params
    params.require(:workout).permit(:name, :descript, :goal_time)
  end
end
