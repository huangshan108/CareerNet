class MainController < ApplicationController
  before_action :confirm_logged_in
  def index
      @name = Account.name
      @jobs = Job.order('created_at')[0..2]
      @events = Event.order('time_start')[0..2]
  end
end
