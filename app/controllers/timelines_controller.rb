class TimelinesController < ApplicationController

  def index
    @timelines = Timeline.where(:song_id => params[:song_id])
    render :json => @timelines, :include => :segments
  end

  def create
    @timeline = Timeline.create(:song_id => params[:song_id])
    render :json => @timeline
  end

  def update
    @timeline = Timeline.find params[:id]
    @timeline.update timeline_params
    @timeline.save
    render :json => @timelines
  end

  def destroy
    # raise params.inspect
    @timeline = Timeline.find params[:id]
    @timeline.destroy
    render :json => @timeline
  end

  private
  def timeline_params
    params.require(:timeline).permit(:id, :song_id)
  end


end