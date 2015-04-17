require 'spec_helper'

describe Appointment do
  describe 'between' do
      before :each do
          @beginning_week = Date.today.at_beginning_of_week
          @appoint1 = FactoryGirl.create(:appointment, day: @beginning_week)
          @staff = @appoint1.staff
          @appoint_same_week = FactoryGirl.create(:appointment, staff: @staff, day: @beginning_week.tomorrow)
          @appoint_last_week = FactoryGirl.create(:appointment, staff: @staff, day: @beginning_week.days_ago(7))
      end

      it 'should return only appointments within start and end' do
        @result = Appointment.between(@beginning_week.to_s, @beginning_week.tomorrow.tomorrow.to_s)
        expect(@result).to include(@appoint1, @appoint_same_week)
        expect(@result).not_to include(@appoint_last_week)
      end

  end

  describe 'string_to_timeslot' do
      it 'should return 4 for 11:00:00' do
          @result = Appointment.string_to_timeslot("11:00:00")
          expect(@result).to eq(4)
      end

      it 'should return 5 for 11:20:00' do
          @result = Appointment.string_to_timeslot("11:20:00")
          expect(@result).to eq(5)
          @result = Appointment.string_to_timeslot("11:40:00")
          expect(@result).to eq(6)
          @result = Appointment.string_to_timeslot("12:00:00")
          expect(@result).to eq(7)
      end

      it 'should return 0 when input in bogus' do
        @result = Appointment.string_to_timeslot("cat")
        expect(@result).to eq(0)
      end

      it 'should return 0 when appointment time not within range' do
        @result = Appointment.string_to_timeslot("18:20:00")
        expect(@result).to eq(0)
      end
  end

  describe 'timeslot_to_string' do
    it 'should have basic functionality' do
          @result = Appointment.timeslot_to_string(5)
          expect(@result).to eq("11:20:00")
          @result = Appointment.timeslot_to_string(6)
          expect(@result).to eq("11:40:00")
          @result = Appointment.timeslot_to_string(7)
          expect(@result).to eq("12:00:00")
    end
  end

  describe 'as_json' do
    before :each do
      @day = "2015-2-3".to_date
      @appt = FactoryGirl.create(:appointment, day: @day, time_slot: 4)
      @staff = @appt.staff
    end

    it 'should correctly convert into json' do
      @result = @appt.as_json
      @expected = {
        title: 'Empty',
        start: '2015-02-03 11:00:00',
        end: '2015-02-03 11:20:00',
        allDay: false,
        id: @appt.id,
        url: "/appointments/student"
      }
      expect(@result).to eq(@expected)
    end
  end

end
