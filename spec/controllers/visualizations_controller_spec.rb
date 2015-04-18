require 'spec_helper'

describe VisualizationsController do
    describe 'GET #student_demographic_data' do
        it 'should not render a view' do
            #json = { :format => 'json', :visualization => { country: ["US"], gender: ["male"], class: ["2017"]}}
            get :student_demographic_data, format: :json
            expect(response).to render_template(layout: false)
        end
    end

end
