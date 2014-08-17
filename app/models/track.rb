# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  duration    :integer
#  looped      :boolean          default(FALSE)
#  song_id     :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  start_time  :integer
#  timeline_id :integer
#

class Track < ActiveRecord::Base
  belongs_to :timeline
  # belongs_to :song, :through => :timeline
  has_many :samples
end
