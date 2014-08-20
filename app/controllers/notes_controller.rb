class NotesController < ApplicationController

  def index
    @notes = Note.where(:segment_id => params[:segment_id])
    render :json => @notes
  end

  def create
    @note = Note.create(point_in_segment: params[:point_in_segment], segment_id: params[:segment_id], sample_path: params[:sample_path] )
    render :json => @note
  end

  def destroy
    @note = Note.find params[:id]
    @note.destroy
    render :text => 'Note destroyed'
  end
end