class EventsController < ApplicationController
  before_action :confirm_logged_in
  def show
    id = params[:id]
    @event = Event.find(id)
  end

  def index
    pages = 10
    @events = Event.all
  end

  def new
  end

  def create
    @event = Event.create(:title => params[:title], :description => params[:description], :location => params[:location])
    redirect_to events_path
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    redirect_to events_path
  end
end
