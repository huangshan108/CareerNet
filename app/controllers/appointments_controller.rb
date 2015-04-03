class AppointmentsController < ApplicationController
  before_action :confirm_logged_in

  respond_to :html, :js, :json

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
          flash[:error] = 'You must be a staff of access this page.'
          redirect_to root_path
          return
      elsif @account.staff == nil
          Staff.new(account: @account)
      else
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

  def destroy
    Appointment.find(params[:id]).destroy
    respond_with layout: false
  end

end
