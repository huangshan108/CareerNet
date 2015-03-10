class JobsController < ApplicationController

  def show
    id = params[:id] # retrieve job ID from URI route
    @job = Jobs.find(id) # look up job by unique ID
  end


  def index
    
  end

  def apply
    @id = params[:id]
    @job = Jobs.find params[:id]
    #@student.update_attributes!(params[:click])
    #flash[:notice] = "You've applied #{job.title}."
    #flash.keep
    #redirect_to action:"show", id: @id
  end
  
  
  def destroy
    @job = Jobs.find(params[:id])
    @job.destroy
    flash[:notice] = "Job '#{@job.title}' deleted."
    redirect_to jobs_path
  end
end
