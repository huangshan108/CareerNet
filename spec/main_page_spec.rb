require 'spec_helper'
include Warden::Test::Helpers

describe "MainPage" do
    before(:each) {
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
