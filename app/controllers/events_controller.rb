class EventsController < ApplicationController
  before_action :confirm_logged_in
  before_action :event_restriction, only:[:create,:destroy,:new]
  def show
    id = params[:id]
    @event = Event.find(id)
    @current_user = Account.find(account_id)
  end

  def index
    @current_user = Account.find(account_id)
    pages = 10
    @events = Event.all
  end

  def new
  end

  def create
    @event = Event.create(:title => params[:title], :description => params[:description], :location => params[:location], :time_start => Time.now, :time_end => Time.now+3600)
    redirect_to events_path
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    redirect_to events_path
  end
end
