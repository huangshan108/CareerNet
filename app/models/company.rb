class Company < ActiveRecord::Base
	belongs_to :account
	has_many :jobs
	has_many :students
end
