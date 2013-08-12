class Comment < ActiveRecord::Base
	include Voteable_Ceconcepcion

	belongs_to :user
	belongs_to :post
	

	validates :comment, presence: true

end