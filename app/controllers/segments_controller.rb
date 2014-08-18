class SegmentsController < ApplicationController

  def index
    # raise params.inspect
    @segments = Segment.where(:timeline_id => params[:timeline_id])
    # last_start_time = @tracks.pluck
    # @last_track = @tracks.where(:start_time => last_start_time)

    # @tracks_data = {
      # :tracks => @tracks,
      # :last_track => @last_track
    # }
    # render :json => @tracks_data
    render :json => @segments
  end

  def create
    @segments = Segment.create(:duration => params[:duration], :timeline_id => params[:timeline_id])
    render :json => @segments
  end

  def update
    @segment = Segment.where(:timeline_id => params[:timeline_id]).where(:id => params[:id]).first
    @segment.update(start_time: params[:start_time])
    @segment.save
    render :json => @segment
  end

  def destroy
  end
end