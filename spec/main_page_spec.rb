require 'spec_helper'

describe "MainPage" do
    before(:each) {
        @current_user = FactoryGirl.create(:account)
        # Login as fake user during test
        # Credit: http://library.edgecase.com/oath-and-capybara 
        if Capybara.current_driver == :webkit
          page.driver.browser.set_cookie("stub_user_id=#{@current_user.id}; path=/; domain=127.0.0.1")
        else
          cookie_jar = Capybara.current_session.driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
          cookie_jar[:stub_user_id] = @current_user.id
        end
        visit root_path
    }
    it 'should direct to jobs page when click jobs' do
        click_link('Jobs')
        expect(page).to have_content 'Job'
        expect(page).to have_content 'Company'
        expect(page).to have_content 'Description'
    end

    it 'should direct to jobs page when click events' do
        click_link('Events')
        expect(page).to have_content 'All Events'
    end

    it 'should direct to jobs page when click my_profile' do
        pending("add link to my_profile")
        click_link('my_profile')
        expect(page).to have_content 'Student Profile'
    end

    it 'should direct to logout page when click logout' do
        click_link('Logout')
        expect(page).to have_content 'Logged out'
    end
end
