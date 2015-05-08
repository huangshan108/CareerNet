class ApplicationsController < ApplicationController
  before_action :confirm_logged_in

  def index
    if params[:company_id]
      render_view("company", params)
    elsif params[:student_id]
      render_view("student", params)
    end
  end

  def render_view(role, params)
    params[:id] = params[(role + "_id").to_sym]
    if authorize([role.to_sym, :self])
      instance = role.humanize.constantize.find(params[(role + "_id").to_sym])
      case role
      when "company"
        @jobs = instance.jobs
      when "student"
        @applications = instance.applications
      end
      render "#{role}_view_applications"
    end
  end

  def int
    session[:application_id] = params[:application_id]
    redirect_to(company_interviews_path)
  end

end
