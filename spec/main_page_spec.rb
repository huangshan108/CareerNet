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
        visit dashboard_path
    }
    it 'should direct to jobs page when click jobs' do
        click_link('Browse Jobs')
        expect(page).to have_content 'Job'
        expect(page).to have_content 'Company'
    end

    it 'should direct to jobs page when click events' do
        click_link('Browse Events')
        expect(page).to have_content 'Event'
        expect(page).to have_content 'Time Start'
        expect(page).to have_content 'Time End'
    end

    it 'should direct to logout page when click logout' do
        click_link('Logout')
        expect(page).to have_content 'Logged out'
    end
end
