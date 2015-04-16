class ApplicationsController < ApplicationController
	def index
		if params[:company_id]
			@jobs = Company.find(params[:company_id]).jobs
			render 'company_view_applications'
		elsif params[:student_id]
			@applications = Student.find(params[:student_id]).applications
			render 'student_view_applications'
		end
	end
  
  def show
    app_id = params[:application_id]
    @application = Application.find_by_id(app_id)
  end
end
