class JobsController < ApplicationController

	def index
		@jobs = Job.all.paginate(page: params[:page], per_page: 10)
	end


end