# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  student_id     :integer
#  application_id :integer
#  time_slot      :integer
#  day            :date
#  description    :text
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Interview do
  describe 'between' do
      before :each do
          @beginning_week = Date.today.at_beginning_of_week
          @interview = FactoryGirl.create(:interview, day: @beginning_week)
          @company = @interview.company
          @interview_same_week = FactoryGirl.create(:interview, company: @company, day: @beginning_week.tomorrow)
          @interview_last_week = FactoryGirl.create(:interview, company: @company, day: @beginning_week.days_ago(7))
      end

      it 'should return only appointments within start and end' do
        @result = Interview.between(@beginning_week.to_s, @beginning_week.tomorrow.tomorrow.to_s)
        expect(@result).to include(@interview, @interview_same_week)
        expect(@result).not_to include(@interview_last_week)
      end

  end

  describe 'as_json' do
    before :each do
      @day = "2015-2-3".to_date
      @interview = FactoryGirl.create(:interview, day: @day, time_slot: 4)
      @company = @interview.company
    end

    it 'should correctly convert into json' do
      @result = @interview.as_json
      @expected = {
        title: 'Empty',
        start: '2015-02-03 11:00:00',
        end: '2015-02-03 11:20:00',
        allDay: false,
        color: "blue",
        id: @interview.id,
        detailURL: "/interviews/student"
      }
      expect(@result).to eq(@expected)
    end
  end

end
