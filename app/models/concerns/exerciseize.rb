module Exerciseize
  extend ActiveSupport::Concern
  included do
    default_scope -> { order(:position => :asc)}
    before_create :set_position
    after_destroy :fix_positions
    before_save :normalize_values
  end

  VALS = {
      :time => %w(Cardio/Aerobic Stretch),
      :weight_unit => ['Weight Lifting'],
      :weight => ['Weight Lifting'],
      :reps => %W(Bodyweight Plyometric #{'Weight Lifting'})
  }
  def user
    container.user
  end
  def set_position
    if container
      self.position = (self.container.children.last.try(:position) || 0) + 1
    end
  end
  def fix_positions
    return false unless container
    self.container.children.each_with_index do |exercise, index|
      exercise.position = index +1
      exercise.save()
    end
  end
  def normalize_values
    self.time = nil unless time?
    self.weight = nil unless weight?
    self.weight_unit = nil unless weight_unit?
    self.reps = nil unless reps?
  end
  def time?
    VALS[:time].include?(kind)
  end
  def reps?
    VALS[:reps].include?(kind)
  end
  def weight?
    VALS[:weight].include?(kind)
  end
  def weight_unit?
    VALS[:weight_unit].include?(kind)
  end

end