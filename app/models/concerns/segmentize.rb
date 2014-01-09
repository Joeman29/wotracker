module Segmentize
  extend ActiveSupport::Concern
  included do
    default_scope ->{ order(:position => :asc)}
    before_create :set_position
    after_destroy :fix_positions
  end
  def fix_positions
    self.container.children.each_with_index do |segment, index|
      segment.position = index +1
      segment.save()
    end
  end
  def set_position
    self.position = (self.container.children.last.try(:position) || 0) + 1
  end
  def user
    container.user
  end
end