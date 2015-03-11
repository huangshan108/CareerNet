class JobsController < ApplicationController

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
