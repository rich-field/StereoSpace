class TracksController < ApplicationController

  def index
    @tracks = Track.where(:song_id => params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end