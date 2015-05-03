class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :account_type, :is_staff?, :delegation_on?, :logged_in?, :account_id, :roll_id, :time_period
  before_action :set_cache_buster

  def set_cache_buster
    expires_now
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def current_user
    @current_user = Account.find(account_id)
  end

  # 1 => student, 2 => staff, 3 => company
  def account_type
    current_user.account_type
  end

  def is_student?
    return account_type == 1
  end

  def is_staff?
    return account_type == 2
  end

  def is_company?
    return account_type == 3
  end

  def current_identity
    if is_student?
      return :student
    elsif is_staff?
      return :staff
    else
      return :company
    end     
  end

  def authorize(identities)
    if !identities.include? :all and !identities.include? current_identity
      flash[:error] = "Unauthorized. Wrong user group."
      redirect_to root_path
      return false
    elsif identities.include? :self and \
      current_identity == identities[identities.index(:self)-1] and \
      current_user.getUser.id != params[:id].to_i
      flash[:error] = "Unauthorized. Privacy violation."
      redirect_to root_path
      return false
    end
    return true
  end

  def account_id
    if delegation_on?
      return session[:signed_in_as]
    else
      return session[:user_id]
    end
  end

  def roll_id
    return current_user.getUser.id
  end

  def logged_in?
    account_id != nil
  end
  
  def delegation_on?
    return !(session[:signed_in_as] == nil)
  end

  # return morning, afternoon or evening
  def time_period
    t = Time.new.hour
    if 5 < t and t <= 12
      return "Morning"
    elsif 12 < t and t <= 18
      return "Afternoon"
    else
      return "Evening"
    end
  end

  private

  def confirm_logged_in
    unless account_id
      flash[:notice] = "Please log in to continue."
      redirect_to(:controller => 'accounts', :action => 'login')
      return false
    else
      return true
    end
  end

  # Private method used to login as a fake user
  # Credit: http://library.edgecase.com/oath-and-capybara
  private
  if Rails.env.test?
    prepend_before_filter :stub_current_user
    def stub_current_user
      session[:user_id] = cookies[:stub_user_id] if cookies[:stub_user_id]
    end
  end
end
