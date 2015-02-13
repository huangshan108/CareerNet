class AccountController < ApplicationController
	before_action :confirm_logged_in, :except => [:login, :confirm_login, :signup, :confirm_signup, :logout]
	before_action :setup_new_account

	def index
	end

	def login
	end

	def confirm_login
	if params[:email].present? && params[:password].present?
		found_user = Account.where(:email => params[:email]).first
		if found_user
			authorized_user = found_user.authenticate(params[:password])
		end
	end
	if authorized_user 
		session[:user_id] = authorized_user.id
		session[:email] = authorized_user.email
		flash[:notice] = "You are now logged in."
		redirect_to(:action => 'index')
	else
	  	flash[:notice] = "Invalid username/password combination."
	  	redirect_to(:action => 'login')
	end
	end

	def signup
	end

	def confirm_signup
		# byebug
		if params[:password] != params[:password2] or params[:password] == ""
			flash[:notice] = "Password does not match!"
			redirect_to(:back)
			return
		end
		# byebug
		@new_account.email = params[:email]
		@new_account.account_type = params[:account_type]
		@new_account.password = params[:password]
		if @new_account.valid?
			if @new_account.save
				flash[:notice] = "Account successfully created!"
				redirect_to(:action => 'login')
				return
			else
				flash[:notice] = "Failed to create account. Please try again."
				redirect_to(:back)
				return
			end
		else
			flash[:notice] = "Invalid field. Please try again."
			redirect_to(:back)
			return
		end

	end

	def logout
	session[:user_id] = nil
	session[:email] = nil
	flash[:notice] = "Logged out"
	redirect_to(:action => "login")
	end
	
	private
	def setup_new_account
		@new_account = Account.new		
	end	
end
