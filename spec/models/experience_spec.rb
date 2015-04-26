# == Schema Information
#
# Table name: experiences
#
#  id          :integer          not null, primary key
#  student_id  :integer
#  org_name    :string
#  job_title   :string
#  yr_exp      :integer
#  salary      :integer
#  city        :string
#  state       :string
#  country     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  industry_id :integer
#  company_id  :integer
#

require 'spec_helper'

describe Experience do
  pending "add some examples to (or delete) #{__FILE__}"
end
