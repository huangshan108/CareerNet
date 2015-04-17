class VisualizationsController < ApplicationController
    def student_demographic
    end

    def student_demographic_data
    		# byebug
        @stud_demo_data = Visualization.student_demographic_json(params[:country], params[:gender], params[:class])
        respond_to do |format|
            format.json { render :json => @stud_demo_data }
        end
    end
end
