# == Schema Information
#
# Table name: notes
#
#  id             :integer          not null, primary key
#  point_in_track :integer
#  soundboard_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#  track_id       :integer
#

class Note < ActiveRecord::Base
  belongs_to :soundboard
end
