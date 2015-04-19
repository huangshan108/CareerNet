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

require 'spec_helper'

describe Event do
  it "creates events" do
      event1 = Event.create!(:title => 'Event1', :description => 'foo')
      event2 = Event.create!(:title => 'Event2', :description => 'foo')
      expect(event1['title']).to eq 'Event1'
      expect(event2['title']).to eq 'Event2'
      expect(event1['description']).to eq 'foo'
      expect(event2['description']).to eq 'foo'
  end
end
