class JobsController < ApplicationController

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