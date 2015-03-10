class Jobs < ActiveRecord::Base
  attr_accessible :title, :company, :description, :salary
end
