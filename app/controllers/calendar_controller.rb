class CalendarController < ApplicationController

	def interviewData
		currentUser = Account.getUser(current_user)
		interviews = currentUser.getInterviews(params[:start], params[:end]) if (params[:start] && params[:end]) else []
		respond_to do |format|
	        format.html
	        format.json { render :json => interviews }
		end
		return
	end

	def eventData
		currentUser = Account.getUser(current_user)
		events = currentUser.getEvents(params[:start], params[:end]) if (params[:start] && params[:end]) else []
		respond_to do |format|
	        format.html
	        format.json { render :json => events }
		end
		return
	end

	def appointmentData
		currentUser = current_user.getUser
		appointments = currentUser.getAppointments(params[:start], params[:end]) if (params[:start] && params[:end]) else []
		respond_to do |format|
	        format.html
	        format.json { render :json => appointments }
		end
		return
	end
end
