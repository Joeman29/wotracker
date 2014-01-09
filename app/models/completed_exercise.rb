class CompletedExercise < ActiveRecord::Base
  belongs_to :completed_segment
  include Exerciseize
  def container
    completed_segment
  end
end
