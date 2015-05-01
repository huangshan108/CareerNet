class VisualizationsController < ApplicationController
    before_action :confirm_logged_in

    def student_demographic
        authorize([:staff])
    end

    def student_demographic_data
        if authorize([:staff])
            @stud_demo_data = Visualization.student_demographic_json(params[:country], params[:gender], params[:class])
            respond_to do |format|
                format.json { render :json => @stud_demo_data }
            end
        end
    end
end
