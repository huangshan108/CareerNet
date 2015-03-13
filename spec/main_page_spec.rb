require 'spec_helper'

describe "MainPage" do
    before(:each) {visit root_path}
    it 'should direct to jobs page when click jobs' do
        pending("paths for navigation to be added")
        click_link('jobs')
        expect(response).to render_template jobs_path
    end

    it 'should direct to jobs page when click events' do
        pending("paths for navigation to be added")
        click_link('events')
        expect(response).to render_template events_path
    end

    it 'should direct to jobs page when click my_profile' do
        pending("paths for navigation to be added")
        click_link('my_profile')
        expect(response).to render_template accounts_profile_path
    end

    it 'should direct to logout page when click logout' do
        click_link('Logout')
        expect(page).to have_content 'Logged out'
    end

    it 'should direct to forgot password path when click forgot password' do
        click_link('Forgot Password?')
        expect(page).to have_selector("input[value='Reset Password']")
    end
end
