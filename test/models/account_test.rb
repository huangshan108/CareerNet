# == Schema Information
#
# Table name: accounts
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string
#  account_type           :integer
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
