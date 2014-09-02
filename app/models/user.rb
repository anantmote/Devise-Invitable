class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #:registerable,
  devise :invitable, :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]
  #:confirmable
  #attr_accessible :username

  validates :username, presence:   true,
             uniqueness: { case_sensitive: false }

  belongs_to :role
  has_many :userlogs

  

end
