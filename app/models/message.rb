class Message
  include ActiveAttr::Model
  attribute :name
  attribute :subject
  attribute :email
  attribute :content
  validates :name, presence: true, length: {minimum: 1}
  validates :content, length: {within: 10..500}, presence: true
  validates :email, :presence => true, :length => {:maximum =>  50},
            :format => {:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
end
