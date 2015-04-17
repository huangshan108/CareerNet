# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  time_start  :time
#  time_end    :time
#  location    :string
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base
end
