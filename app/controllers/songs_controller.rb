class SongsController < ApplicationController
  def index
    @songs = Song.all
    render :json => @songs
  end

  def create
    @song = Song.new
    @song.duration = 30000
    @song.timelines << Timeline.create
    @song.share_url = (0...20).map { ('a'..'z').to_a[rand(26)] }.join #makes random string
    until @song.save
      @song.share_url = (0...20).map { ('a'..'z').to_a[rand(26)] }.join
    end
    render :json => @song
  end

  def update
    @song = Song.find(:share_url => params[:id])
    @song.save
    render :json => @song
  end

  def destroy
  end
end