require 'rails_helper'

RSpec.describe SongsController, :type => :controller do
  before do
    3.times do |i|
      song = Song.new(:share_url => "dsauyufihkdsjhfias#{i}")
      song.save
    end
  end

  describe 'GET /songs' do
    before do
      get :index
    end
    it 'should assign @songs to all songs' do
      expect( assigns(:songs).count ).to eq(3)
    end
  end

  describe 'CREATE /songs' do
    before do
      get :create
    end
    it 'should create a song' do
      expect( assigns(:songs).count ).to eq(3)
    end
  end

end
