class Application < ActiveRecord::Base
	belongs_to :student
	belongs_to :job
  has_many :interviews
end
