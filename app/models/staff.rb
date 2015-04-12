class Staff < ActiveRecord::Base
    has_many :appointments
    has_many :students, :through => :appointments
    has_many :interviews
    has_many :interviews, :through => :applications
    belongs_to :account
end
