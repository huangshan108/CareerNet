# == Schema Information
#
# Table name: students
#
#  id              :integer          not null, primary key
#  major_id        :integer
#  first_name      :string
#  last_name       :string
#  graduation_date :date
#  college_id      :integer
#  resume_link     :string
#  created_at      :datetime
#  updated_at      :datetime
#  account_id      :integer
#  country         :string
#  gender          :string
#

require 'will_paginate'

class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
	belongs_to :account

  has_many :appointments
  has_many :staffs, :through => :appointments

	has_many :applications
	has_many :jobs, :through => :applications
	has_many :studentskills
	has_many :skills, through: :studentskills


end
