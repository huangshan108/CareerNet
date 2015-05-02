class MainController < ApplicationController
  before_action :confirm_logged_in
  
  def index
    if authorize([:all])
      @name = Account.name
      @current_user = current_user
      @jobs = Job.order('created_at')
      if @jobs.length >= 3
        @jobs = @jobs[-3, 3].reverse
      end
      @events = Event.where('time_start > ?', DateTime.now).order('time_start')
      if @events.length >= 3
        @events = @events[0..2]
      end
    end
  end
end
