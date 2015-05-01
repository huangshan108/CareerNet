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
      timeslot = Interview.string_to_timeslot(starttime_str)
      endslot = Interview.string_to_timeslot(endtime_str)
      app = Application.find_by_id(params[:application_id])
      error = false
      while timeslot < endslot do
        interview_params = { day: starttime_str, time_slot: timeslot, company: curr_company, application: app }
        @intr = Interview.new(interview_params)
        timeslot += 1
        error = @intr.save and error
      end

      respond_to do |format|
        if error
            format.json { render json: {msg: 'You have successfully registed your slot.'} }
        else
            format.json { render json: {msg: 'Error. Your interview slot was not registered.'}, :status => 500 }
        end
      end
    end
  end

  def curr_company
    if authorize([:company])
      @account = current_user
      if @account.company == nil
          Company.new(account: @account)
      else
          @account.company
      end
    end
  end

  def index_company
    if authorize([:company])
      @company = curr_company
      @interviews = @company.interviews.between(params[:start], params[:end]) if (params[:start] && params[:end])

      respond_to do |format|
        format.html
        format.json { render :json => @interviews }
      end
    end
  end

  def destroy
    if authorize([:company])
      Interview.find(params[:id]).destroy
      respond_with layout: false
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
      @companies = Company.all
      @application = Application.find(params[:application_id])
      @student = current_user.student
    end
  end

  def student_book
    if authorize([:student])
      interview = Interview.find(params[:id])
      if interview.student == nil
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
