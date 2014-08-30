window.app = window.app or {}
app.Router = Backbone.Router.extend
  routes:
    "": "index"
    "songs/:id": "show" # Individual Song
    # "songs": "songsIndex" # All Songs

  initialize: ->
    # Init these two to be false, as you aren't playing or recording whenyou first get to the page
    app.playing = false
    app.recording = false

    # Init the seeker to be at the start of the timeline
    app.seekerPosition = 0

  # Creates a new song and redirects you to its share url after it's done creating ut in the database
  index: ->
    app.song = new app.Song({title: 'New song', duration: 30000})
    app.song.save().done ->
      app.router.navigate("songs/#{app.song.get('share_url')}", true)

  # Sends you to the song with the share url
  # If not found, send you to the song instantiated at @index
  show: (id) ->
    app.song = app.songs.findWhere(share_url: id) or app.song

    # This is supposed to prevent from sending you to bogus links
    # unless app.song
      # app.router.navigate('', true)

    # Instantiates a view for the song
    view = new app.SongShowView(model: app.song)
    view.render()

  # This gets a full list of songs in the database
  # songsIndex: ->
  #   app.songs.fetch().done ->
  #     view = new app.SongsView({collection: app.songs})
  #     view.render()



