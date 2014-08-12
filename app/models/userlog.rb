class Userlog < ActiveRecord::Base


	has_many :users
	has_many :pages


  	belongs_to :user
  	belongs_to :page

  	#default_scope -> { order('timespent desc ') } #should be category_id

end
