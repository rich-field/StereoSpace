class NotesController < ApplicationController

  def index
    @notes = Note.where()
  end

  def show
  end
end