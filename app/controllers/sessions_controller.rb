class SessionsController < ApplicationController
	before_action :require_user, only: [:destroy]
	before_action :deny_login, only: [:new, :create]

	def new
	end

	def create

		user = User.find_by(username:(params[:username]))
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id 
			redirect_to root_path, notice: "You have successfully logged in!"
		else
			flash[:error] =  "Unable to find username and password combination"
			redirect_to login_path
		end

	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
	end

private
	def deny_login
		if logged_in?
			flash[:error] =  "You are already logged in"
			redirect_to root_path
		end
	end

end