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

require 'rails_helper'

RSpec.describe Song, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
