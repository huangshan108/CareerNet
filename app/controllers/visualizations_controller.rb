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

    def industry
        @template_name = "Industry"
        render 'general_stats'
    end

    def industry_data
    	@salary_by_industry = Industry.get_industry_vis_data(params[:country], params[:gender], params[:class])
    	respond_to do |format|
    		format.json { render :json => @salary_by_industry}
    	end
    end

    def organization
        @template_name = "Organization"
        render 'general_stats'
    end

    def organization_data
    	@salary_by_organization = Company.get_company_vis_data(params[:country], params[:gender], params[:class])
    	respond_to do |format|
    		format.json { render :json => @salary_by_organization}
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
