class MainController < ApplicationController
  def index
      @name = Account.name
  end
end
