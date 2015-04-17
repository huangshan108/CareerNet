class ApplicationController < ActionController::Base
    
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	helper_method :current_user, :account_type, :logged_in?, :account_id, :roll_id, :time_period
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
    
  #student can't edit other student's profile, so does company
  #student and company can't create and destroy an event
  #student can't view company's application
  #company can't view student's application
  private
  def profile_restriction
    id = params[:id]
    #if not a staff
    if account_type != 2
      if roll_id.to_i != id.to_i or account_type == 3
          error_message
      end
    end
    return true
  end
  
  private
  def event_restriction
      id = params[:id]
      unless account_type == 2
          error_message
      else
       return true
      end
  end
  
  #this use :student_id and company_id as params,i can't combine them together since
  #other controller use :id
  private
  def application_restriction
    if account_type == 3
        id = params[:company_id]
        if roll_id.to_i != id.to_i #try vistit other company
          error_message
          elsif params[:student_id] #try visit student
         error_message
        end
    elsif account_type == 1
        id = params[:student_id]
        if roll_id.to_i != id.to_i #try vistit other stduent
            error_message
        elsif params[:company_id] #try vistit company
            error_message
        end
    end
  end
  
  
  #only company can post and delete jobs and company can't delete other company's job
  private
  def job_restriction
      id = params[:id]
      if account_type != 3
          error_message
      else
      #might be more stuff here
          return true
      end
          
  end


  #company can't delete other company's job
  private
  def job_restriction2
      # id = params[:id]
      if account_type != 3
           error_message
      elsif account_type == 3
          @company = Company.find_by_id(roll_id);
            job_id = params[:job_id]
        @job = Job.find_by_id(job_id)
        if (@job.company.name.to_s.eql? @company.name.to_s) == false
          error_message
        end
      else 
        return true 
      end 
  end
  
  private
  
  def error_message
      flash[:notice] = "You don't have the persmission to perform the action."
      redirect_to(:controller => 'main', :action => 'index')
      return false
  end
  

	# return morning, afternoon or evening
	def time_period
		t = Time.new.hour
		if 5 < t and t <= 12
			return "Morning"
		elsif 12 < t and t <= 18
			return "Afternoon"
		else
			return "Evening"
		end
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
