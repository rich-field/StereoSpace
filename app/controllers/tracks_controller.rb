class TracksController < ApplicationController

  def index
    @tracks = Track.where(:song_id => params[:song_id])
    render :json => @tracks
  end

  def create
  end

  def update
  end

  def destroy
  end
end