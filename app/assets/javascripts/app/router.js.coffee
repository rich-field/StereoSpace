window.app = window.app or {}
app.Router = Backbone.Router.extend
  routes:
    "": "index"
    "songs/:id": "show" # Individual Song
    "songs": "songsIndex" # All Songs

  initialize: ->
    console.log('Routes have been initialized')

  index: ->
    app.song = new app.Song
    view = new app.SongShowView( model: app.song )
    view.render()

  show: (id) ->
    console.log('show page hath been reachethed')
    app.song = app.songs.get(id)
    view = new app.SongShowView( model: app.song )
    view.render()

  songsIndex: ->
    # should make fetch happen here
    view = new app.SongsView({collection: app.songs})
    view.render()

