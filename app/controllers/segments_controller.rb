class SegmentsController < ApplicationController

  def index
    @segments = Segment.where(:timeline_id => params[:timeline_id])
    render :json => @segments, :include => :notes
  end

  def create
    @segments = Segment.create(:duration => params[:duration], :timeline_id => params[:timeline_id])
    render :json => @segments
  end

  def update
    @segment = Segment.where(:timeline_id => params[:timeline_id]).where(:id => params[:id]).first
    @segment.update(start_time: params[:start_time])
    render :json => @segment
  end

  def destroy
    @segment = Segment.find params[:id]
    @segment.destroy
    render :text => "#{@segment.id} destroyed"
  end
end