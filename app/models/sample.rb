# == Schema Information
#
# Table name: samples
#
#  id            :integer          not null, primary key
#  sound         :string(255)
#  soundboard_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Sample < ActiveRecord::Base
  belongs_to :track
  has_many :notes
end
