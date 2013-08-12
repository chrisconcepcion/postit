class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :login_name


  def require_admin # helps controller
    access_denied unless current_user && current_user.admin?
  end  

  def login_name #helps view
  	User.find(session[:user_id]).username
  end



  def current_user #helps controller and view
  	@current ||= User.find(session[:user_id]) if session[:user_id]

  end

  def current_user_id
  	if logged_in?
  		session[:user_id]
  	end
  end

  def logged_in? #helps controllers
  	!!current_user
  end

  def require_user #helps controller
  	unless logged_in?
  		flash[:error] = "You must be logged in for this request"
  		redirect_to root_path
  	end
  end

  def access_denied # helps controller
  	flash[:error] = "Access denied"
  	redirect_to root_path
  end
end
