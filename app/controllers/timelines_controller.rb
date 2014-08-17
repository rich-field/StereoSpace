class TimelinesController < ApplicationController

  def index
    @timelines = Timeline.where(:song_id => params[:song_id])
    render :json => @timelines
  end

  def new

  end

  def update

  end

  def destroy

  end


end