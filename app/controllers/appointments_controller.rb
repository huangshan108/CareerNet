class AppointmentsController < ApplicationController
  before_action :confirm_logged_in
  def index_staff
      @account = Account.find(session[:user_id])
      if @account.account_type != 2
          flash[:error] = 'You must be a staff of access this page.'
          redirect_to root_path
          return
      elsif @account.staff == nil
          @staff = Staff.new(account: @account)
      else
          @staff = @account.staff
      end
      @appt_this_week = Appointment.appointments_this_week(@staff)
  end
end
