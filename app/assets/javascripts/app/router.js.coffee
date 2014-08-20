window.app = window.app or {}
app.Router = Backbone.Router.extend
  routes:
    "": "index"
    "songs/:id": "show" # Individual Song
    "songs": "songsIndex" # All Songs

  initialize: ->

  index: ->

    app.song = new app.Song({title: 'New song', duration: 10000})
    view = new app.SongShowView( model: app.song )
    view.render()

  show: (id) ->
    app.song = app.songs.get(id)
    view = new app.SongShowView( model: app.song )
    view.render()

  songsIndex: ->
    view = new app.SongsView({collection: app.songs})
    view.render()

