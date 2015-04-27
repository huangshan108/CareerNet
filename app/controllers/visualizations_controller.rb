class VisualizationsController < ApplicationController
    def student_demographic
    end

    def student_demographic_data
        @stud_demo_data = Visualization.student_demographic_json(params[:country], params[:gender], params[:class])
        respond_to do |format|
            format.json { render :json => @stud_demo_data }
        end
    end

    def salary_by_state
    end

    def salary_by_state_data
        @salary_by_state = Visualization.salary_by_region_usa_json(params[:country], params[:gender], params[:class])
        respond_to do |format|
            format.json { render :json => @salary_by_state }
        end
    end

    def us_map_json
        @us_map_json = File.read(File.join(Rails.root, 'app', 'assets', 'jsons', 'us.json'))
        respond_to do |format|
            format.json { render :json => @us_map_json }
        end
    end
end
