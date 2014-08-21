# == Schema Information
#
# Table name: segments
#
#  id          :integer          not null, primary key
#  duration    :integer
#  start_time  :integer
#  looped      :boolean          default(FALSE)
#  timeline_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Segment < ActiveRecord::Base
  belongs_to :timeline
  has_many :notes, :dependent => :destroy
end
