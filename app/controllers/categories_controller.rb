class CategoriesController < ActionController::Base
	def index
		@category = Category.all
	end

	def show
		@category = Category.find(params[:id])
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


	def category_params
		params.require(:category).permit(:name)
	end

end