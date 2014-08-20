class NotesController < ApplicationController

  def index
    @notes = Note.where(:segment_id => params[:segment_id])
    render :json => @notes
  end

  def create
  end

  def destroy
    @note = Note.find params[:id]
    @note.destroy
    render :text => 'Note destroyed'
  end
end