# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  duration   :integer
#  looped     :boolean          default(FALSE)
#  song_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  start_time :integer
#

class Track < ActiveRecord::Base
  belongs_to :song
  has_many :notes
end
