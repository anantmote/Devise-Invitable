class Page < ActiveRecord::Base

	validates :title,  presence: true, length: { maximum: 25 }, uniqueness: true
	validates :content,  presence: true
	validates :categorie_id,  presence: true

	belongs_to :categorie #this is spelt wrong. It's "category". Its spelt wrong all over.
	has_many :userlogs

	default_scope -> { order('categorie_id') } #should be category_id
end
