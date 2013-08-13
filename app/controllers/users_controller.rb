class UsersController < ApplicationController
	before_action :require_user, only: [:edit, :update]
	before_action :set_user, only: [:edit, :show, :update]
	before_action :require_creator, only: [:edit]
	

	def new
		@user = User.new
	end

	def show
		
	end
	
	def edit
		
	end	
	
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id 
			redirect_to posts_path, notice: "You have registered successfully! Now go log in."
		else
			render :new
		end	
	end

	def update
		if @user.update(user_params) 
			flash[:notice] = "Your profile was updated."
      		redirect_to user_path
		else
			render :edit
		end
	end

private

	def user_params
		params.require(:user).permit(:username, :password, :phone, :email, :about)
	end

  	def set_user
  		@user = User.find_by_slug(params[:id])
  	end

	def require_creator
    	access_denied unless logged_in? && current_user.id == @user.id
  	end


end