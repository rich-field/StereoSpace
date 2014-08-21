window.app = window.app or {}
app.Router = Backbone.Router.extend
  routes:
    "": "index"
    "songs/:id": "show" # Individual Song
    "songs": "songsIndex" # All Songs

  initialize: ->
    app.playing = false # Init app.playing to be false
    app.recording = false # Init app.recording to be false
    app.seekerPosition = 0
  index: ->
    # Creates a new song and redirects you to its page
    app.song = new app.Song({title: 'New song', duration: 30000})
    app.song.save().done ->
      app.router.navigate("songs/#{app.song.get('share_url')}", true)

  show: (id) ->
    app.song = app.songs.findWhere(share_url: id) or app.song
    # unless app.song
      # app.router.navigate('', true)
    view = new app.SongShowView(model: app.song)
    view.render()

  songsIndex: ->
    app.songs.fetch().done ->
      view = new app.SongsView({collection: app.songs})
      view.render()



