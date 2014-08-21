# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  duration   :integer
#  title      :string(255)
#  genre      :string(255)
#  share_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Song < ActiveRecord::Base
  has_many :timelines, :dependent => :destroy
  has_many :segments, :through => :timelines
  validates :share_url, :uniqueness => true
end
