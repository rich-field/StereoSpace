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
  has_many :segments, :dependent => :destroy
  has_many :notes, through: :segments
  belongs_to :song
end
