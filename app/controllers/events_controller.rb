class EventsController < ApplicationController
  before_action :confirm_logged_in

  def show
    if authorize([:all])
      id = params[:id]
      @event = Event.find(id)
      @current_user = Account.find(account_id)
    end
  end

  def index
    if authorize([:all])
      @current_user = Account.find(account_id)
      pages = 10
      @events = Event.all
    end
  end

  def registered_index
    @current_user = Account.find(account_id)
    params[:id] = @current_user.getUser.id
    if authorize([:all])
      pages = 10
      @events = @current_user.events
    end
  end

  def attendees_index
    if authorize([:staff, :company])
      @event = Event.find params[:event_id]
      @attendees = @event.accounts
    end
  end

  def new
    authorize([:staff, :company])
  end


  def create
    if authorize([:staff, :company])
      @time_start = Time.new(generate_time_arr(params, 5))
      @time_end = Time.new(generate_time_arr(params, 5))
      premitted_attributes = [:title, :description, :location]
      @event = Event.create(:time_start => @time_start, :time_end => @time_end)
      @event.update_attributes(create_new_attrs(premitted_attributes, params))
      flash[:notice] = "Successfully created event."
      redirect_to events_path
    end
  end

  def generate_time_arr(params, times)
    arr = []
    times.times do |i|
      arr << params[:time_start]["{:prompt=>true}(1#{i})"].to_i
    end
    arr
  end

  def destroy
    if authorize([:staff, :company])
      @event = Event.find params[:id]
      @event.destroy
      flash[:notice] = "Successfully deleted event."
      redirect_to events_path
    end
  end

  def register
    if authorize([:all])
      @event = Event.find params[:event_id]
      @current_user = Account.find(account_id)
      @event.accounts << @current_user
      flash[:notice] = "Successfully registered for event."
      redirect_to events_path
    end
  end
end
