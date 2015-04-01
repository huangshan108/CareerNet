class AppointmentsController < ApplicationController
  before_action :confirm_logged_in

  def index_staff
  end

  def student_show
  	account = Account.find(session[:user_id])
  	if account.account_type == 1
  		@student = account.student
  		@appointments = @student.appointments
  	else
        flash[:error] = "This page is only available to students."
        redirect_to(:root)
  	end
  end

  def student_new
  	@staffs = Staff.all
  	@student = Account.find(session[:user_id]).student
  end

  def student_book
  	appointment = Appointment.find(params[:id])
  	if appointment.student == nil
  	  appointment.update_attribute(:student, Account.find(session[:user_id]).student)
  	  flash[:notice] = "Appointment has been made."
  	  redirect_to(appointment_student_show_path)
  	else
      flash[:error] = "Selected appointment is no longer available."
      redirect_to(appointment_student_new_path)
  	end
  end

  def student_cancel
  	appointment = Appointment.find(params[:id])
  	if appointment.student == Account.find(session[:user_id]).student
  	  appointment.update_attribute(:student, nil)
  	  flash[:notice] = "Appointment has been cancelled."
  	else
  	  flash[:error] = "You do not have permission to cancel this appointment."
  	end
  	redirect_to(appointment_student_show_path)
  end

end
