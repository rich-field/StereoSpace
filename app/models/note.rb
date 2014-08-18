# == Schema Information
#
# Table name: notes
#
#  id               :integer          not null, primary key
#  point_in_segment :integer
#  sample_id        :integer
#  segment_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Note < ActiveRecord::Base
  belongs_to :sample
end
