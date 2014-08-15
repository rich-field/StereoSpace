# == Schema Information
#
# Table name: soundboards
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Soundboard < ActiveRecord::Base
  has_many :samples
end
