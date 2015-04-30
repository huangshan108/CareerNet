class VisualizationsController < ApplicationController
    def student_demographic
    end

    def student_demographic_data
        @stud_demo_data = Visualization.student_demographic_json(params[:country], params[:gender], params[:class])
        respond_to do |format|
            format.json { render :json => @stud_demo_data }
        end
    end

    def industry
        @template_name = "Industry"
        render 'general_stats'
    end

    def industry_data
    	@industry_data = Industry.get_industry_vis_data(params)
    	respond_to do |format|
    		format.json { render :json => @industry_data}
    	end
    end

    def organization
        @template_name = "Organization"
        render 'general_stats'
    end

    def organization_data
    	@company_data = Company.get_company_vis_data(params)
    	respond_to do |format|
    		format.json { render :json => @company_data}
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

end
