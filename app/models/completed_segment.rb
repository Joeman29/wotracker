class CompletedSegment < ActiveRecord::Base
  has_many :completed_exercises, dependent: :destroy
  belongs_to :completed_workout
  accepts_nested_attributes_for :completed_exercises, allow_destroy: true
  include Segmentize
  def container
    completed_workout
  end
  def children
    completed_exercises
  end
end
