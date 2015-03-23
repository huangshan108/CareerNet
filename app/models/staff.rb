class Staff < ActiveRecord::Base
    has_many :appointments
    has_many :students, :through => :appointments
    belongs_to :account
end
