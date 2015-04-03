class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	helper_method :current_user, :account_type, :logged_in?, :account_id, :roll_id
	def current_user
		@current_user = Account.find(account_id)
	end

	# 1 => student, 2 => staff, 3 => company
	def account_type
		current_user.account_type
	end

	def account_id
		session[:user_id]
	end

	def roll_id
		session[:roll_id]
	end

	def logged_in?
		account_id != nil
	end

  private
	
	def confirm_logged_in
		unless account_id
			flash[:notice] = "Please log in to continue."
			redirect_to(:controller => 'accounts', :action => 'login')
			return false
		else
			return true
		end
	end

	# Private method used to login as a fake user
	# Credit: http://library.edgecase.com/oath-and-capybara
	private
	if Rails.env.test?
	  prepend_before_filter :stub_current_user
	  def stub_current_user
	    session[:user_id] = cookies[:stub_user_id] if cookies[:stub_user_id]
	  end
	end
end
