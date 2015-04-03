class JobsController < ApplicationController
  before_action :confirm_logged_in
  def index
    pages = 10
    @jobs = Job.all.paginate(page: params[:page], per_page: pages)
  end
    
  def new
  end
  
  def create
    @job = Job.create!(:title => params[:title], :description => params[:description], :company_id => params[:company_id],:salary => params[:salary])
    flash[:notice] = "#{@job.title} was successfully created."
    redirect_to job_list_path
  end


  def view
    job_id = params[:job_id]
    @job = Job.find_by_id(job_id)
    @current_user = Account.find(session[:user_id])
  end

  def delete
    @job = Job.find params[:job_id]
    @job.destroy
    flash[:notice] = "The Job #{@job.title} deleted."
    redirect_to job_list_path
  end

  def view_posted_jobs
    pages = 10
    @jobs = Company.find(session[:roll_id]).jobs.paginate(page: params[:page], per_page: pages)
    render 'index'
  end

  def apply
    @application = Application.create(:student_id => session[:roll_id], :job_id => params[:job_id])
    flash[:notice] = "You application has been submitted!"
    ApplicationsMailer.application_confirmation_email_student(@application).deliver_now
    ApplicationsMailer.application_confirmation_email_company(@application).deliver_now
    redirect_to view_single_job_path(params[:job_id])
  end

  def user_params
    params.require(:jobs).permit(:title, :company_id, :description, :salary)
  end

end
