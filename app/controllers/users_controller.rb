class UsersController < ApplicationController
	before_action :require_user, only: [:new, :create]
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
		params.require(:user).permit(:username, :password, :email, :about)
	end

  	def set_user
  		@user = User.find(params[:id])
  	end

	def require_creator
    	access_denied unless logged_in? && current_user.id == @user.id
  	end


end