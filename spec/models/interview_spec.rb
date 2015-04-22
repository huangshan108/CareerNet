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

  describe 'string_to_timeslot' do
      it 'should return 4 for 11:00:00' do
          @result = Interview.string_to_timeslot("11:00:00")
          expect(@result).to eq(4)
      end

      it 'should return 5 for 11:20:00' do
          @result = Interview.string_to_timeslot("11:20:00")
          expect(@result).to eq(5)
          @result = Interview.string_to_timeslot("11:40:00")
          expect(@result).to eq(6)
          @result = Interview.string_to_timeslot("12:00:00")
          expect(@result).to eq(7)
      end

      it 'should return 0 when input in bogus' do
        @result = Interview.string_to_timeslot("cat")
        expect(@result).to eq(0)
      end

      it 'should return 0 when appointment time not within range' do
        @result = Interview.string_to_timeslot("18:20:00")
        expect(@result).to eq(0)
      end
  end

  describe 'timeslot_to_string' do
    it 'should have basic functionality' do
          @result = Interview.timeslot_to_string(5)
          expect(@result).to eq("11:20:00")
          @result = Interview.timeslot_to_string(6)
          expect(@result).to eq("11:40:00")
          @result = Interview.timeslot_to_string(7)
          expect(@result).to eq("12:00:00")
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
