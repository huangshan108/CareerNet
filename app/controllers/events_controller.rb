class EventsController < ApplicationController
  before_action :confirm_logged_in
  def show
    id = params[:id]
    @event = Event.find(id)
  end

  def index
    @events = Event.all
  end

  def new
  end

  def create
    @event = Event.create!(:title => params[:title], :description => params[:description], :location => params[:location])
    redirect_to events_path
  end

=begin
  def update
    @event = Event.find params[:id]
    @event.update_attributes!(params[:event])
    redirect_to event_path(@event)
  end
=end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    redirect_to events_path
  end
end
