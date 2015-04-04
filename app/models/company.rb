class Company < ActiveRecord::Base
	belongs_to :account
	has_many :jobs
end
