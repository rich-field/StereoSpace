class TracksController < ApplicationController

  def index
    @tracks = Track.where(:song_id => params[:song_id])
    render :json => @tracks
  end

  def create
    @track = Track.create(:duration => params[:duration], :song_id => params[:song_id])
    render :json => @track
  end

  def update
    @track = Track.where(:song_id => params[:song_id])
    @track.save
    render :json => @track
  end

  def destroy
  end
end