class SegmentsController < ApplicationController

  def index
    @segments = Segment.where(:timeline_id => params[:timeline_id])
    render :json => @segments, :include => :notes
  end

  def create
    @segments = Segment.create(:start_time => params[:start_time], :timeline_id => params[:timeline_id])
    render :json => @segments
  end

  def update
    @segment = Segment.where(:timeline_id => params[:timeline_id]).where(:id => params[:id]).first
    @segment.update(start_time: params[:start_time]) if params[:start_time]
    @segment.update(duration: params[:duration]) if params[:duration]
    render :json => @segment
  end

  def destroy
    @segment = Segment.find params[:id]
    @segment.destroy
    render :text => "#{@segment.id} destroyed"
  end
end