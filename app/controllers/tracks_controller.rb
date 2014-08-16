class TracksController < ApplicationController

  def index
    @tracks = Track.all
    render :json => @tracks
  end

  def create
  end

  def update
  end

  def destroy
  end
end