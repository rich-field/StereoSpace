# == Schema Information
#
# Table name: timelines
#
#  id         :integer          not null, primary key
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Timeline < ActiveRecord::Base
  has_many :tracks
  belongs_to :song
end
