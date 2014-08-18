window.app = window.app or {}

app.NoteView = Backbone.View.extend
  el: '.track'

  initialize: ->
  render: ->
    $note = $('<div/>')
    $note.addClass('note')
    $note.css('left', @.model.get('point_in_segment'))
    return $note