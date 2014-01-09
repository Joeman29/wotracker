class SegmentsController < ApplicationController
  include Authenticating
  respond_to :json
  def list
  end

  def show
    @segment = Segment.find(params[:id])
    respond_with @segment
  end
  def index
    @segments = Segment.where(workout_id: params[:workout_id]).take()
    respond_with @segments
  end
  def new
  end

  def create
    @segment =  Segment.new(segment_params)
    @segment.workout_id = params[:workout_id]
    @segment.save!
    redirect_to action: 'show', id: @segment.id
  end

  def edit
  end

  def update
    @segment = Segment.find(params[:id])
    @segment.update(segment_params)
    respond_with @segment
  end

  def destroy
    @segment = Segment.find(params[:id])
    @segment.destroy
    render :nothing => true
  end
  private
  def segment_params
    params.require(:segment).permit(:name, :rest_time, :position, :sets )
  end
end
