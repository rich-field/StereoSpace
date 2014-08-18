window.app = window.app or {}

app.NoteView = Backbone.View.extend
  el: '.track'

  initialize: ->
    console.log('note rendered')
    console.log(@.model)
  render: ->
