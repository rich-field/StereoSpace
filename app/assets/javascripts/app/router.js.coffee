window.app = window.app or {}
app.Router = Backbone.Router.extend
  routes:
    "": "index"
    "songs/:id": "show" # Individual Song
    "songs": "songsIndex" # All Songs

  initialize: ->
    console.log('Routes have been initialized')

  index: ->
    app.appView = new app.AppView

  show: (id) ->
    console.log('show page hath been reachethed')
    app.song = app.songs.get(id)
    console.log(app.song)
    view = new app.SongShowView( model: app.song )
    view.render()

  songsIndex: ->
    view = new app.SongsView({collection: app.songs})
    view.render()
    console.log("lols")

