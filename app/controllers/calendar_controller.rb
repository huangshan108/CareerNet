class CalendarController < ApplicationController
    before_action :confirm_logged_in

    def interviewData
        if authorize([:all])
            serveData(:interviews)
        end
    end

    def eventData
        if authorize([:all])
            serveData(:events)
        end
    end

    def appointmentData
        if authorize([:all])
            serveData(:appointments)
        end
    end

    def serveData(type)
        data = []
        if params[:confirmed] == 'true'
            case type
            when :events
                data = current_user.getEvents(params[:start], params[:end])
            when :appointments
                data = !is_company? ? current_user.getAppointments(params[:start], params[:end]) : []
            when :interviews
                data = !is_staff? ? current_user.getInterviews(params[:start], params[:end]) : []
            else
            end
        else
            case type
            when :events
                data = Event.between(params[:start], params[:end])
            when :appointments
                data = Appointment.between(params[:start], params[:end])
            when :interviews
                data = Interview.between(params[:start], params[:end])
            else
            end
        end
        renderJSON(data)
    end

    def renderJSON(data)
        respond_to do |format|
            format.html
            format.json { render :json => data }
        end
        return
    end

end
