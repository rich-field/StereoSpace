window.app = window.app or {}
app.Router = Backbone.Router.extend
  routes:
    "": "index"
    "songs/:id": "show" # Individual Song
    "songs": "songsIndex" # All Songs

  initialize: ->
    console.log('Routes have been initialized')

  index: ->

  show: (id) ->

  songsIndex: ->

