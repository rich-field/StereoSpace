# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  duration    :integer
#  start_time  :integer
#  looped      :boolean          default(FALSE)
#  timeline_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Track < ActiveRecord::Base
  belongs_to :timeline
  # belongs_to :song, :through => :timeline
  has_many :samples
end
