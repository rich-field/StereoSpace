# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  duration   :integer
#  title      :string(255)
#  genre      :string(255)
#  user_id    :integer
#  share_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Song < ActiveRecord::Base
end
