class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :posts

	validates :comment, presence: true
end