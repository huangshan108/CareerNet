class ApplicationsController < ApplicationController
    before_action :application_restriction
	def index
		if params[:company_id]
			@jobs = Company.find(params[:company_id]).jobs
			render 'company_view_applications'
		elsif params[:student_id]
			@applications = Student.find(params[:student_id]).applications
			render 'student_view_applications'
		end
	end
end
