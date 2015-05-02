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
            params[:id] = params[:student_id]
            if authorize([:student, :self])
                @applications = Student.find(params[:student_id]).applications
                render 'student_view_applications'
            end
        end
    end

  def int
    session[:application_id] = params[:application_id]
    redirect_to(company_interviews_path)
  end

end
