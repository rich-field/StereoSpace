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
    @song = Song.find params[:id]
    @song.save
    render :json => @song
  end

  def destroy
  end
end