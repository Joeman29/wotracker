class Exercise < ActiveRecord::Base
  belongs_to :segment
  include Exerciseize
  def container
    segment
  end
end