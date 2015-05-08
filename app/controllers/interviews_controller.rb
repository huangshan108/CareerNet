class InterviewsController < ApplicationController
  before_action :confirm_logged_in

  respond_to :html, :js, :json

  def new
    @interview = Interview.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def company_new
    if authorize([:company])
      starttime_str = params[:start].to_s
      endtime_str = params[:end].to_s
      timeslot = Appointment.string_to_timeslot(starttime_str)
      endslot = Appointment.string_to_timeslot(endtime_str)
      error = false
      while timeslot < endslot do
        interview_params = { day: starttime_str, time_slot: timeslot, company: current_user.getUser, application_id: session[:application_id], status: "Pending"}
        @intr = Interview.new(interview_params)
        timeslot += 1
        error = @intr.save and error
      end
      time_slot_reponse(error)
    end
  end

  def index_company
    if authorize([:company])
      @interviews = current_user.getUser.interviews.between(params[:start], params[:end]) if (params[:start] && params[:end])

      respond_to do |format|
        format.html
        format.json { render :json => @interviews }
      end
    end
  end

  def show
    @current_user = Account.find(account_id)
    @interview = Interview.find(params[:id])
    if @current_user.account_type != 3 and current_user.student != @interview.student
      flash[:notice] = "You are not authorized to view that interview."
      redirect_to(interview_student_show_path)
    end
  end

  def app
    session[:application_id] = params[:application_id]
    redirect_to(company_interviews_path)
  end

  def company_update
    Interview.find(params[:id]).update_attributes(:description => params[:description], :status => params[:status], :note => params[:note])
    redirect_to(company_interviews_path)
  end

  def destroy
    if authorize([:company])
      Interview.find(params[:id]).destroy
      respond_to do |format|
        format.json { render :json => true }
      end
    end
  end

  def student_show
    if authorize([:student])
      account = current_user
      if account.account_type == 1
        if account.student == nil
          Student.new(account: account)
        end
        @student = account.student
        @interviews = @student.interviews
      else
        flash[:error] = "This page is only available to students."
        redirect_to(:root)
        return
      end
    end
  end

  def student_new
    if authorize([:student])
      @student = Account.find(session[:user_id]).student
      @application = Application.find params[:application_id]
      @interviews = @application.interviews
      if @interviews.any? {|interview| interview.student}
        redirect_to(interview_student_show_path)
      end
    end
  end

  def student_book
    if authorize([:student])
      interview = Interview.find(params[:id])
      if interview.application.interviews.any? {|interview| interview.student}
        flash[:notice] = "You have already scheduled an interview slot for this application."
      elsif interview.student == nil
        interview.update_attribute(:student, current_user.student)
        flash[:notice] = "Interview has been scheduled."
      end
      redirect_to(interview_student_show_path)
    end
  end

  def student_cancel
    interview = Interview.find(params[:id])
    params[:id] = interview.student.id
    if authorize([:student, :self])
      interview.update_attribute(:student, nil)
      flash[:notice] = "Interview has been cancelled."
      redirect_to(interview_student_show_path)
    end
  end

end
