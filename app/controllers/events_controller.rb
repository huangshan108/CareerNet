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

  def registered_index
    @current_user = Account.find(account_id)
    pages = 10
    @events = @current_user.events
  end

  def attendees_index
    @event = Event.find params[:event_id]
    @attendees = @event.accounts
  end

  def new
  end


  def create
    @time_start = Time.new(params[:time_start]["{:prompt=>true}(1i)"].to_i, params[:time_start]["{:prompt=>true}(2i)"].to_i, params[:time_start]["{:prompt=>true}(3i)"].to_i, params[:time_start]["{:prompt=>true}(4i)"].to_i, params[:time_start]["{:prompt=>true}(5i)"].to_i)
    @time_end = Time.new(params[:time_end]["{:prompt=>true}(1i)"].to_i, params[:time_end]["{:prompt=>true}(2i)"].to_i, params[:time_end]["{:prompt=>true}(3i)"].to_i, params[:time_end]["{:prompt=>true}(4i)"].to_i, params[:time_end]["{:prompt=>true}(5i)"].to_i)
    @event = Event.create(:title => params[:title], :time_start => @time_start, :time_end => @time_end, :description => params[:description], :location => params[:location])
    flash[:notice] = "Successfully created event."
    redirect_to events_path
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    flash[:notice] = "Successfully deleted event."
    redirect_to events_path
  end

  def register
    @event = Event.find params[:event_id]
    @current_user = Account.find(account_id)
    @event.accounts << @current_user
    flash[:notice] = "Successfully registered for event."
    redirect_to events_path
  end
end
