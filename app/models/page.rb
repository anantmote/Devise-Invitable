class Page < ActiveRecord::Base

	validates :title,  presence: true, length: { maximum: 25 }, uniqueness: true
	validates :content,  presence: true
	validates :categorie_id,  presence: true

	belongs_to :categorie
	     
	default_scope -> { order('categorie_id') }
end
