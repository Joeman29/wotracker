class CompletedWorkout < ActiveRecord::Base
  has_many :completed_segments, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :completed_segments, allow_destroy: true
  def children
    completed_segments
  end
end
