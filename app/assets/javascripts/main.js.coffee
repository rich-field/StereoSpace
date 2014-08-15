window.app = window.app or {}
$(document).ready ->
  app.templates = {


  }

  app.tracks = new app.Tracks()
  app.samples = new app.Samples()
  app.notes = new app.Notes()
  app.songs = new app.Songs()
  app.soundboards = new app.Soundboards()

  console.log('write some words')