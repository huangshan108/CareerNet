class Company < ActiveRecord::Base
	belongs_to :account
	has_many :jobs
  has_many :applications
  has_many :interviews
  has_many :students, :through => :applications
end
