# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  duration   :integer
#  looped     :boolean
#  song_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  belongs_to :song
  belongs_to :user
  has_many :notes
end
