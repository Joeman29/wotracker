class Segment < ActiveRecord::Base
  belongs_to :workout
  has_many :exercises, dependent: :destroy
  include Segmentize
  accepts_nested_attributes_for :exercises
  def container
    workout
  end
  def children
    exercises
  end
end
