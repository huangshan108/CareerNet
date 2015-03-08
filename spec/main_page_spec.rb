describe "MainPage" do
    it 'should direct to jobs page when click jobs' do
        click_button('jobs')
        expect(response).to render_template jobs_path
    end

    it 'should direct to jobs page when click events' do
        click_button('events')
        expect(response).to render_template events_path
    end

    it 'should direct to jobs page when click my_profile' do
        click_button('my_profile')
        expect(response).to render_template accounts_profile_path
    end
end
