class User < ActiveRecord::Base
  has_many :workouts, dependent: :destroy
  has_many :completed_workouts, dependent: :destroy
  attr_accessor :password
  before_save :hash_password , if: -> { password }
  validates :username, :presence => true, :uniqueness => true,
            :length => {:maximum => 50}
  validates :email, :presence => true, :length => {:maximum =>  50},
            :format => {:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ },
            :uniqueness => true
  validates :password, :presence => true, :length => {:minimum => 5}, :confirmation => {:message => "Passwords don't match"}, :on => :create
  validates :password, :presence => true, :length => {:minimum => 5}, :confirmation => {:message => "Passwords don't match"}, :on => :update
  validates :first_name, :presence => {:message => 'Enter first name'}, :length => {:within => 2..50}
  validates :last_name, :presence => {:message => 'Enter last name'}, :length => {:within => 2..50}

  def authenticate?(pwd)
    encrypted_password(pwd) == hashed_password
  end
  private
  def make_salt
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  def encrypted_password(pwd = password)
    self.salt ||=make_salt
    Digest::SHA1.hexdigest("Put #{salt} on the #{pwd}")
  end
  def hash_password
     self.hashed_password = encrypted_password
  end
end
