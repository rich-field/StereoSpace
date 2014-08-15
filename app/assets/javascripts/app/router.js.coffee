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

  songsIndex: ->
    app.songsView = new app.SongsView({collection: app.songs})
    console.log("lols")
