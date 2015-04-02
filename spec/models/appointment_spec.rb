require 'spec_helper'

describe Appointment do
  describe 'appointments_this_week' do
      before :each do
          @beginning_week = Date.today.at_beginning_of_week
          @appoint1 = FactoryGirl.create(:appointment, day: @beginning_week)
          @staff = @appoint1.staff
          @appoint2 = FactoryGirl.create(:appointment, staff: @staff, day: @beginning_week.tomorrow)
          @appoint_last_week = FactoryGirl.create(:appointment, staff: @staff, day: @beginning_week.days_ago(7))
      end

      it 'should set up factory correctly' do
          expect(@appoint1.staff).to eq @appoint2.staff
      end

      it 'should return only appointments in this week' do
          @result = Appointment.appointments_this_week(@staff)
          expect(@result).to include(@appoint1, @appoint2)
          expect(@result).not_to include(@appoint_last_week)
      end
  end

  describe 'appointments_weeks_ago' do
      before :each do
          @weeks_ago = 2
          @beginning_week = Date.today.at_beginning_of_week
          @appt_this_week = FactoryGirl.create(:appointment, day: @beginning_week)
          @staff = @appt_this_week.staff
          @appt_two_weeks_ago = FactoryGirl.create(:appointment, 
                                                   staff: @staff, 
                                                   day: @beginning_week.days_ago(7 * @weeks_ago))
          @appt_before_two_weeks = FactoryGirl.create(:appointment, 
                                                      staff: @staff, 
                                                      day: @beginning_week.days_ago(7 * (@weeks_ago+1)))
      end

      it 'should return only appointments in the week of two weeks ago' do
          @result = Appointment.appointments_weeks_ago(@staff, @weeks_ago)
          expect(@result).to include(@appt_two_weeks_ago)
          expect(@result).not_to include(@appt_this_week, @appt_before_two_weeks)
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

end
