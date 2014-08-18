window.app = window.app or {}
$(document).ready ->
  app.templates = {
    appView: $('#app-template').html()
    songsView: $('#songs-template').html()
    songView: $('#song-template').html()
    songShowView: $('#song-show-template').html()
    timelineView: $('#timeline-template').html()
    timelinesView: $('#timelines-template').html()
    segmentView: $('#segment-template').html()
  }

  app.segments = new app.Segments
  app.samples = new app.Samples
  app.notes = new app.Notes
  app.songs = new app.Songs
  app.soundboards = new app.Soundboards

  startApp = ->
    app.router = new app.Router
    Backbone.history.start()

  counter = 0

  app.songs.fetch().done ->
    counter++
    startApp() if counter == 1