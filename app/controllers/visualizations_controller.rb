class VisualizationsController < ApplicationController
    def student_demographic
    end

    def student_demographic_data
        @stud_demo_data = Visualization.student_demographic_json(params[:countries], params[:genders], params[:classes])
        respond_to do |format|
            format.json { render :json => @stud_demo_data }
        end
    end
end
