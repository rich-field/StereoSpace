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

require 'rails_helper'

RSpec.describe Sample, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
