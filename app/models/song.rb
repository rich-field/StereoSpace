# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  duration   :integer
#  title      :string(255)
#  genre      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Song < ActiveRecord::Base
  belongs_to :user
end
