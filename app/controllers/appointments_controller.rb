class AppointmentsController < ApplicationController
  before_action :confirm_logged_in

  respond_to :html, :js, :json

#  def index
#    if authorize([:student, :staff])
#      if is_student?
#        redirect_to appointment_student_show_path
#      else is_staff?
#        redirect_to staff_appointments_path
#      end
#    end
#  end

  def new
    @appointment = Appointment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def staff_new
    if authorize([:staff])
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
  end

  def curr_staff
    if authorize([:staff])
      @account = current_user
      if @account.staff == nil
          Staff.new(account: @account)
      else
          @account.staff
      end
    end
  end

  def index_staff
    if authorize([:staff])
      @staff = curr_staff
      @appointments = @staff.appointments.between(params[:start], params[:end]) \
       if (params[:start] && params[:end])

      respond_to do |format|
        format.html
        format.json { render :json => @appointments }
      end
    end
  end

  def show
    @current_user = Account.find(account_id)
    @appointment = Appointment.find(params[:id])
    if @current_user.account_type != 2 and @current_user.account_type == 1 and @current_user.student != @appointment.student
      flash[:notice] = "You are not authorized to view that appointment."
      redirect_to(appointment_student_show_path)
    end
  end

  def staff_update
    Appointment.find(params[:id]).update_attribute(:note, params[:note])
    redirect_to(staff_appointments_path)
  end

  def destroy
    if authorize([:staff])
      Appointment.find(params[:id]).destroy
      respond_to do |format|
          format.json { render :json => true }
      end
    end
  end

  def student_show
    if authorize([:student])
      account = current_user
      if account.student == nil
        Student.new(account: account)
      end
      @student = account.student
      @appointments = @student.appointments
    end
  end

  def student_new
    if authorize([:student])
      @staffs = Staff.all
      @student = current_user.student
    end
  end

  def student_book
    if authorize([:student])
      appointment = Appointment.find(params[:id])
    end
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
    params[:id] = appointment.student.id
    if authorize([:student, :self])
      appointment.update_attributes(:student => nil, :reason => nil, :description => nil)
      flash[:notice] = "Appointment has been cancelled."
      redirect_to(appointment_student_show_path)
    end
  end

end
