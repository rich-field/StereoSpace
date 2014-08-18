class TracksController < ApplicationController

  def index
    # raise params.inspect
    @tracks = Track.where(:timeline_id => params[:timeline_id])
    # last_start_time = @tracks.pluck
    # @last_track = @tracks.where(:start_time => last_start_time)

    # @tracks_data = {
      # :tracks => @tracks,
      # :last_track => @last_track
    # }
    # render :json => @tracks_data
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