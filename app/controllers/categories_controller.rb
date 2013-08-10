class CategoriesController < ApplicationController
	before_action :require_user, only: [:new, :create]
	before_action :require_admin, only: [:new, :create]

	def index
		@category = Category.all
	end

	def show
		@category = Category.find_by_slug(params[:id])
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.create(category_params)
		if @category.save
			redirect_to categories_path, notice: "Category saved!"
		else
			render :new
		end
	end

private
	
	def category_params
		params.require(:category).permit(:name)
	end
end