# == Schema Information
#
# Table name: notes
#
#  id             :integer          not null, primary key
#  point_in_track :integer
#  sample_id      :integer
#  track_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe Note, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
