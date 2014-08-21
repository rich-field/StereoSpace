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
  before { Song.create }

  it 'should increase the songs in the database' do
    expect( Song.count ).to eq(1)
  end

  # it 'should make a song in the database' do
    # expect { Song.create }.to change(Song, :count).from(1).to(2)
  # end


end
