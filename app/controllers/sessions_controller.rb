class SessionsController < ApplicationController
	before_action :require_user, only: [:destroy]
	before_action :deny_login, only: [:new, :create]

	def new
	end

	def create

		user = User.find_by(username:(params[:username]))
		if user && user.authenticate(params[:password])
			if user.two_factor_auth?
				session[:two_factor] = true
				user.generate_pin!
				redirect_to pin_path
			else
				session[:user_id] = user.id 
				redirect_to root_path, notice: "You have successfully logged in!"
			end
		else
			flash[:error] =  "Unable to find username and password combination"
			redirect_to login_path
		end

	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
	end

	def pin
		access_denied if session[:two_factor].nil?
		if request.post?
		 user = User.find_by pin: params[:pin]
		 	if user
		 		user.remove_pin!
		 		user.send_pin_to_twilio
		 		session[:two_factor] = nil
				session[:user_id] = user.id
				redirect_to root_path, notice: "You have successfully logged in!"
			else
				flash[:error] =  "Pin does not match."
				redirect_to pin_path
			end
		end
	end

private
	def deny_login
		if logged_in?
			flash[:error] =  "You are already logged in"
			redirect_to root_path
		end
	end

end