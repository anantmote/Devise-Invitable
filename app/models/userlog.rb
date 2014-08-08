class Userlog < ActiveRecord::Base

	has_many :users
	has_many :pages

end
