class ExerciseSerializer < ActiveModel::Serializer
  attributes :id
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
