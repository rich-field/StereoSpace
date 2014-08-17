class TracksController < ApplicationController

  def index
    # raise params.inspect
    @tracks = Track.where(:timeline_id => params[:timeline_id])
    render :json => @tracks
  end

  def create
    @track = Track.create(:duration => params[:duration], :timeline_id => params[:timeline_id])
    render :json => @track
  end

  def update
    @track = Track.where(:timeline_id => params[:timeline_id])
    @track.save
    render :json => @track
  end

  def destroy
  end
end