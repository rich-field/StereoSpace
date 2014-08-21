require 'rails_helper'

RSpec.describe SongsController, :type => :controller do
  before do
    3.times do
      Song.create
    end
  end

  describe '.index' do
    it 'should assign @songs to all songs' do
      expect( assigns(:songs) ).to eq(3)
    end
  end
end
