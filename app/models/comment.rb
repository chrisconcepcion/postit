class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	has_many :votes, as: :voteable

	validates :comment, presence: true

	def total_votes
		self.votes.where(vote: true).size - self.votes.where(vote: false).size
	end
end