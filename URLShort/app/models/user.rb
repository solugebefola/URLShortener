class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  def initialize(email)
    @email = email
  end
  
end
