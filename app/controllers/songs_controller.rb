class SongsController < ApplicationController
  def index
    @songs = Song.all
    render :json => @songs
  end

  def create
    @song = Song.new
    @song.share_url = (0...20).map { ('a'..'z').to_a[rand(26)] }.join
    until @song.save
      @song.share_url = (0...20).map { ('a'..'z').to_a[rand(26)] }.join #makes random
    end
    render :json => @song
  end

  def update
    @song = Song.find params[:id]
    @song.save
    render :json => @song
  end

  def destroy
  end
end