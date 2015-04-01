class JobsController < ApplicationController
	before_action :confirm_logged_in
	def index
		pages = 10
		if params[:sort]
			session[:sort] = params[:sort]
		end
		if session[:sort]
			@jobs = Job.order(session[:sort]).paginate(page: params[:page], per_page: pages)
		else
			@jobs = Job.all.paginate(page: params[:page], per_page: pages)
		end
	end
    
    def new
    end
    
    def create
        @job = Job.create!(:title => params[:title], :description => params[:description], :company_id => params[:company_id],:salary => params[:salary])
        flash.keep[:notice] = "#{@job.title} was successfully created."
        redirect_to job_list_path
    end

	# def show
	# id = params[:id] # retrieve job ID from URI route
	# @job = Job.find_by_id(id) # look up job by unique ID
	# end

	# def create
	#   @job = Job.create!(params[:job])
	# end

	def apply
		id = params[:id]
		@job = Job.find_by_id(id)
        @current_user = Account.find(session[:user_id])
	end

	def destroy
	    @job = Job.find params[:id]
	    @job.destroy
	    flash.keep[:notice] = "The Job #{@job.title} deleted."
	    redirect_to job_list_path
    end

	def user_params
	params.require(:jobs).permit(:title, :company_id, :description, :salary)
	end

end
