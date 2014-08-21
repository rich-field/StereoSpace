window.app = window.app or {}
app.Router = Backbone.Router.extend
  routes:
    "": "index"
    "songs/:id": "show" # Individual Song
    "songs": "songsIndex" # All Songs

  initialize: ->
    # $('body').html('')
    # $('body').html(app.Preloader)
    app.playing = false # Init app.playing to be false
    app.recording = false # Init app.recording to be false
    app.seekerPosition = 0
  index: ->
    # preloader goes here
    # loads all sounds
    # when done, open songView
    app.song = new app.Song({title: 'New song', duration: 30000})
    app.song.save().done ->
      app.router.navigate("songs/#{app.song.get('id')}", true)
    # view = new app.SongShowView( model: app.song )
    # view.render()

  show: (id) ->
    app.song = app.songs.findWhere(share_url: id)
    view = new app.SongShowView( model: app.song )
    view.render()

  songsIndex: ->
    view = new app.SongsView({collection: app.songs})
    view.render()



