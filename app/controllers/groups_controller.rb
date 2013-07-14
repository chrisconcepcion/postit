class GroupsController < ApplicationController
	def show
		@category = Category.find(params[:id])
		@user = User.find(params[:id])
	end
end