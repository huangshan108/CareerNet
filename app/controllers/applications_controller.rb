class ApplicationsController < ApplicationController
    before_action :confirm_logged_in

	def index
		if params[:company_id]
			params[:id] = params[:company_id]
			if authorize([:company, :self])
				@jobs = Company.find(params[:company_id]).jobs
				render 'company_view_applications'
			end
		elsif params[:student_id]
			params[:id] = params[:company_id]
			if authorize([:student, :self])
				@applications = Student.find(params[:student_id]).applications
				render 'student_view_applications'
			end
		end
	end
  
  def show
    app_id = params[:application_id]
    @application = Application.find_by_id(app_id)
  end
end
