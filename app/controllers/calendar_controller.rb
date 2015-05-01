class CalendarController < ApplicationController
	  before_action :confirm_logged_in

	def interviewData
		currentUser = current_user.getUser
		if params[:confirmed] == 'true'
			interviews = currentUser.getInterviews(params[:start], params[:end])
		else
			all = Interview.between(params[:start], params[:end])
		end	
		renderJSON(interviews)
	end

	def eventData
		currentUser = current_user.getUser
		if params[:confirmed] == 'true'
			events = currentUser.getEvents(params[:start], params[:end])
		else
			events = Event.between(params[:start], params[:end])
		end
		renderJSON(events)
	end

	def appointmentData
		currentUser = current_user.getUser
		appointments = []
		if params[:confirmed] == 'true'
			appointments = currentUser.getAppointments(params[:start], params[:end])
		else
			appointments = Appointment.between(params[:start], params[:end])
		end
		renderJSON(appointments)
	end

	def renderJSON(data)
		respond_to do |format|
	        format.html
	        format.json { render :json => data }
		end
		return
	end

end
