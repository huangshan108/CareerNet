class JobsController < ApplicationController
  before_action :confirm_logged_in
  
  def index
    if authorize([:all])
      pages = 10
      @jobs = Job.all
      @current_user = current_user
    end
  end
    
  def new
    authorize([:company])
  end
  
  def create
    if authorize([:company])
      @job = Job.create(
        :title => params[:title], 
        :description => params[:description], 
        :company_id => roll_id,
        :salary => params[:salary]
      )
      flash[:notice] = "#{@job.title} was successfully created."
      redirect_to job_list_path
    end
  end


  def view
    if authorize([:all])
      job_id = params[:job_id]
      @job = Job.find_by_id(job_id)
      @company = Company.find_by_id(roll_id);
      @current_user = current_user
    end
  end

  def delete
    @job = Job.find params[:job_id]
    params[:id] = @job.company_id
    if authorize([:company, :self])
      @job.destroy
      flash[:notice] = "The job #{@job.title} deleted."
      redirect_to job_list_path
    end
  end

  def view_posted_jobs
    if authorize([:all])
      pages = 10
      @jobs = Company.find(roll_id).jobs
      render 'index'
    end
  end

  def apply
    if authorize([:student])
      @application = Application.create(:student_id => roll_id, :job_id => params[:job_id])
      flash[:notice] = "Your application has been submitted!"
      ApplicationsMailer.application_confirmation_email_student(@application).deliver_now
      ApplicationsMailer.application_confirmation_email_company(@application).deliver_now
      redirect_to view_single_job_path(params[:job_id])
    end
  end

  def user_params
    params.require(:jobs).permit(:title, :company_id, :description, :salary)
  end

end
