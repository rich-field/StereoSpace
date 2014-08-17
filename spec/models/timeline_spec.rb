# == Schema Information
#
# Table name: timelines
#
#  id         :integer          not null, primary key
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Timeline, :type => :model do
  # it { is_expected.to have_many(:tracks) }
  it { should have_many :tracks }
end
