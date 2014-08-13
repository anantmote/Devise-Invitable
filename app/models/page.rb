class Page < ActiveRecord::Base

	validates :title,  presence: true, length: { maximum: 25 }, uniqueness: true
	validates :content,  presence: true
	validates :categorie_id,  presence: true

	belongs_to :categorie #this is spelt wrong. It's "category". Its spelt wrong all over.
	has_many :userlogs

	default_scope -> { order('categorie_id') } #should be category_id


	def self.search(query)
	    # where(:title, query) -> This would return an exact match of the query
	    where("title like ? OR content = ? ", "%#{query}%","%#{query}%") 
	end

end
