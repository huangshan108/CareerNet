class MainController < ApplicationController
  before_action :confirm_logged_in
  def index
      @name = Account.name
  end
end
