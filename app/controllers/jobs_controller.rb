class JobsController < ApplicationController

<<<<<<< HEAD
	def index
		pages = 10
		if params[:sort]
			session[:sort] = params[:sort]
		end
		if session[:sort]
			@jobs = Job.order(session[:sort]).paginate(page: params[:page], per_page: pages)
		elsif 
			@jobs = Job.order(session[:sort]).paginate(page: params[:page], per_page: pages)
		else
			@jobs = Job.all.paginate(page: params[:page], per_page: pages)
		end
	end


end
=======
  def show
    id = params[:id] # retrieve job ID from URI route
    @job = Job.find_by_id(id) # look up job by unique ID
  end


  def index
    
  end

  def create
      @job = Job.create!(params[:job])
  end

  def apply
    id = params[:id]
    @job = Job.find_by_id(id)
  end

  def user_params
    params.require(:jobs).permit(:title, :company, :description, :salary)
  end

end
>>>>>>> origin/iteration1-2-viewjob
