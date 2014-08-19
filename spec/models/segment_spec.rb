# == Schema Information
#
# Table name: segments
#
#  id          :integer          not null, primary key
#  duration    :integer
#  start_time  :integer
#  looped      :boolean          default(FALSE)
#  timeline_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Segment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
