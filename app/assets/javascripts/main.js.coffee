window.app = window.app or {}
$(document).ready ->
  app.templates = {
    appView: $('#app-template').html()
    songsView: $('#songs-template').html()

  }

  app.tracks = new app.Tracks()
  app.samples = new app.Samples()
  app.notes = new app.Notes()
  app.songs = new app.Songs()
  app.soundboards = new app.Soundboards()

  console.log('write some words')

  startApp = ->
    app.router = new app.Router
    Backbone.history.start()


  # poop = ->

  counter = 0
  app.songs.fetch().done ->
    # poop()
    (->
      counter ++
      startApp() if counter == 1)()