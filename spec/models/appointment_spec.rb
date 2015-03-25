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

end
