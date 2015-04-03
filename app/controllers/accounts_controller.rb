class AccountsController < ApplicationController
    before_action :confirm_logged_in, :except => [:login, :confirm_login, :signup, :confirm_signup, :forgot_password, :reset_password, :start_reset_password, :submit_reset_password, :reset_password_confirmation, :logout]
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
        case authorized_user.account_type
        when 1
            session[:roll_id] = authorized_user.student.id
        when 2
            session[:roll_id] = authorized_user.staff.id
        when 3
            session[:roll_id] = authorized_user.company.id
        else
        end
        # After logging in, directed to main page instead of account#index
        redirect_to(root_path)
    else
        flash[:error] = "Invalid username/password combination."
        redirect_to(:action => 'login')
    end
    end

    def signup
    end

    def confirm_signup
        found_user = Account.where(:email =>params[:email]).first
        if found_user
            flash[:error] = "Email already exist."
            redirect_to(:back)
            return
        end
        @new_account.email = params[:email]
        @new_account.account_type = params[:account_type]
        @new_account = associate_roll params[:account_type], @new_account
        @new_account.password = params[:password]
        @new_account.name = params[:username]
        if @new_account.valid? and @new_account.save
            flash[:notice] = "Account successfully created!"
            redirect_to(:action => 'login')
            return
        else
            flash[:error] = "Invalid field. Please check your email or password."
            redirect_to(:back)
            return
        end
    end

    def associate_roll account_type, new_account
        # byebug
        case account_type
        when "1"
            student = Student.create
            new_account.student = student
        when "2"
            roll_record = Staff.create
            new_account.staff = staff
        when "3"
            roll_record = Company.create
            new_account.company = company
        end
        return new_account
    end

    def forgot_password

    end

    def reset_password
        found_user = Account.where(:email => params[:email]).first
        if not found_user
            flash[:error] = "Account not found!"
            redirect_to(:back)
            return
        end
        @reset_password_email = params[:email]
        found_user.send_password_reset
        redirect_to reset_password_confirmation_path
    end

    def reset_password_confirmation
        
    end

    def start_reset_password
        @account = Account.find_by_password_reset_token!(params[:password_reset_token])
    end

    def submit_reset_password
        @account = Account.find_by_password_reset_token!(params[:password_reset_token])
        if @account.password_reset_sent_at < 2.hours.ago
            redirect_to account_forgot_password_path, :notice => "Password reset link has expired."
            return
        elsif @account.update_attributes(:password => params[:password])
            redirect_to account_login_path, :notice => "Password reset successfully!"
            return
        end
    end

    def logout
        session[:user_id] = nil
        session[:email] = nil
        session[:roll_id] = nil
        flash[:notice] = "Logged out"
        redirect_to(:action => "login")
    end
    
    private
    def setup_new_account
        @new_account = Account.new      
    end
end
