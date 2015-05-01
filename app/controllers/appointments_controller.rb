class AppointmentsController < ApplicationController
  before_action :confirm_logged_in

  respond_to :html, :js, :json

  def index
    if account_type == 1
      redirect_to appointment_student_show_path
    elsif account_type == 2
      redirect_to staff_appointments_path
    else
      flash[:error] = 'You must be a staff or a student to access this page.'
      redirect_to dashboard_path
    end
  end

  def new
    @appointment = Appointment.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def staff_new
      starttime_str = params[:start].to_s
      endtime_str = params[:end].to_s
      timeslot = Appointment.string_to_timeslot(starttime_str)
      endslot = Appointment.string_to_timeslot(endtime_str)
      error = false
      while timeslot < endslot do
        appt_params = { day: starttime_str, time_slot: timeslot, staff: curr_staff }
        @appt = Appointment.new(appt_params)
        timeslot += 1
        error = @appt.save and error
      end
      
      respond_to do |format|
        if error
            format.json { render json: {msg: 'You have successfully registed your slot.'} }
        else
            format.json { render json: {msg: 'Error. Your appointment was not registered.'}, :status => 500 }
        end
      end
  end

  #def appt_params
  #    appt_date = params[:start].to_date
  #    appt_time = params[:start].to_time
  #    time_slot = Appointment.string_to_timeslot(params[:start].to_s)
  #    {
  #      day: appt_date,
  #      time_slot: time_slot
  #    }
  #end
  def curr_staff
      @account = Account.find(session[:user_id])
      if @account.account_type != 2
          flash[:error] = 'You must be a staff to access this page.'
          redirect_to root_path
          return
      elsif @account.staff == nil
          Staff.new(account: @account)
      else
          #@account.staff.first_name = "Hye"
          #@account.staff.last_name = "Cho"
          #@account.staff.save
          @account.staff
      end
  end

  def index_staff
      @staff = curr_staff
      #@appointments = Appointment.appointments_this_week(@staff)
      @appointments = @staff.appointments.between(params[:start], params[:end]) if (params[:start] && params[:end])

      respond_to do |format|
        format.html
        format.json { render :json => @appointments }
      end
  end

  def show
    @current_user = Account.find(account_id)
    @appointment = Appointment.find(params[:id])
    if @current_user.account_type != 2
      if @current_user.account_type == 1 and @current_user.student != @appointment.student
        flash[:notice] = "You are not authorized to view that appointment."
        redirect_to(appointment_student_show_path)
      end
    end
  end

  def staff_update
    Appointment.find(params[:id]).update_attribute(:note, params[:note])
    redirect_to(staff_appointments_path)
  end

  def destroy
    Appointment.find(params[:id]).destroy
    respond_to do |format|
        format.json { render :json => true }
    end
  end

  def student_show
    account = Account.find(session[:user_id])
    if account.account_type == 1
      if account.student == nil
        Student.new(account: account)
      end
      @student = account.student
      @appointments = @student.appointments
    else
      flash[:error] = "This page is only available to students."
      redirect_to(:root)
      return
    end
  end

  def student_new
    @staffs = Staff.all
    @student = Account.find(session[:user_id]).student
  end

  def student_book
    appointment = Appointment.find(params[:id])
  end

  def student_update
    appointment = Appointment.find(params[:id])
    if appointment.student == nil
      appointment.update_attributes(:student => Account.find(session[:user_id]).student, :reason => params[:reason], :description => params[:description])
      flash[:notice] = "Appointment has been made."
      redirect_to(appointment_student_show_path)
    else
      flash[:error] = "Selected appointment is no longer available."
      redirect_to(appointments_student_show_path)
    end
  end


  def student_cancel
    appointment = Appointment.find(params[:id])
    if appointment.student == Account.find(session[:user_id]).student
      appointment.update_attributes(:student => nil, :reason => nil, :description => nil)
      flash[:notice] = "Appointment has been cancelled."
    else
      flash[:error] = "You do not have permission to cancel this appointment."
    end
    redirect_to(appointment_student_show_path)
  end

end
