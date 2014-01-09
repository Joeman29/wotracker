class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :segments
  validates :name, presence: true
  validates :goal_time, numericality: true
  accepts_nested_attributes_for :segments
  def children
    segments
  end
end
