class SongsController < ApplicationController
  def index
    @songs = Song.all
    render :json => @songs
  end

  def update
  end

  def destroy
  end
end