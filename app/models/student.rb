# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  major_id         :integer
#  first_name       :string
#  last_name        :string
#  graduation_date  :date
#  college_id       :integer
#  resume_link      :string
#  created_at       :datetime
#  updated_at       :datetime
#  account_id       :integer
#  country          :string
#  gender           :string
#  notes            :text
#  years_experience :integer
#  class_of         :integer
#




require 'will_paginate'

class Student < ActiveRecord::Base
  belongs_to :college
  belongs_to :major
  belongs_to :account
  belongs_to :company

  belongs_to :industry

  has_many :appointments
  has_many :staffs, :through => :appointments

  has_many :applications
  has_many :jobs, :through => :applications
  
  has_many :interviews
  has_many :companies, :through => :interviews
    
  has_and_belongs_to_many :skills
  has_many :experiences, dependent: :destroy

	has_many :projects, dependent: :destroy

	has_many :activities, dependent: :destroy

	has_many :educations, dependent: :destroy

end
