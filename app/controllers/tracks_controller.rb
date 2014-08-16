class TracksController < ApplicationController

  def index
    raise params.inspect
    @tracks = Track.where(:song_id => params[:id])
    render :json => @tracks
  end

  def create
  end

  def update
  end

  def destroy
  end
end