# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  website    :string
#  address    :string
#  account_id :integer
#  brief      :text
#  created_at :datetime
#  updated_at :datetime
#  city       :string
#  state      :string
#  country    :string
#  industry   :string
#

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
