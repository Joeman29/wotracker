class SegmentSerializer < ActiveModel::Serializer
  attributes :id
  has_many :exercises
  self.root = false
  def attributes
    data = super
    #if attr == :all
    object.attribute_names.each do |name|
      data[name] = object[name]
    end
    data
  end
end
