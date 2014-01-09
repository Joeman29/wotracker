class WorkoutSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes  :id
  has_many :segments
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
