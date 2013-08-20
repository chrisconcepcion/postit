class Post < ActiveRecord::Base
	include Voteable_Ceconcepcion
	include Slugs

	belongs_to :user
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	


	validates :title, presence: true
	validates :url, presence: true
	validates :description, presence: true
	after_validation { |c| c.generate_slug self.title }

	 
	def to_param
	    self.slug
	end

	def to_param22222
	    self.slug
	end

	def total_votes
		self.votes.where(vote: true).size - self.votes.where(vote: false).size
	end
end