class SongsController < ApplicationController
  def index
    @songs = Song.all
    render :json => @songs
  end

  def create
    @song = Song.new
    # @song.tracks
    @song.save
    render :json => @song
  end

  def update
  end

  def destroy
  end
end