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

require 'rails_helper'

RSpec.describe Track, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
