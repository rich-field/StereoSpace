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

class Note < ActiveRecord::Base
  belongs_to :sample
end
