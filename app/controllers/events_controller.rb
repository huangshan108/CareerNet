class EventsController < ApplicationController
  before_action :confirm_logged_in
  def show
    id = params[:id]
    @event = Event.find(id)
  end

  def index
    pages = 10
    if params[:event_sort]
      session[:event_sort] = params[:event_sort]
    end
    if session[:event_sort]
      @events = Event.order(session[:event_sort]).paginate(page: params[:page], per_page: pages)
    else
      @events = Event.all.paginate(page: params[:page], per_page: pages)
    end
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
