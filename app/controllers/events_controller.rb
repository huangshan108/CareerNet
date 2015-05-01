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
      @time_start = Time.new(params[:time_start]["{:prompt=>true}(1i)"].to_i, params[:time_start]["{:prompt=>true}(2i)"].to_i, params[:time_start]["{:prompt=>true}(3i)"].to_i, params[:time_start]["{:prompt=>true}(4i)"].to_i, params[:time_start]["{:prompt=>true}(5i)"].to_i)
      @time_end = Time.new(params[:time_end]["{:prompt=>true}(1i)"].to_i, params[:time_end]["{:prompt=>true}(2i)"].to_i, params[:time_end]["{:prompt=>true}(3i)"].to_i, params[:time_end]["{:prompt=>true}(4i)"].to_i, params[:time_end]["{:prompt=>true}(5i)"].to_i)
      @event = Event.create(:title => params[:title], :time_start => @time_start, :time_end => @time_end, :description => params[:description], :location => params[:location])
      flash[:notice] = "Successfully created event."
      redirect_to events_path
    end
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
