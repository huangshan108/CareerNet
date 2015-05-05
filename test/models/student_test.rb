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

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
