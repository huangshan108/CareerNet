class MainController < ApplicationController
  before_action :confirm_logged_in
  def index
      @name = Account.name
      @current_user = Account.find(account_id)
  end
end
