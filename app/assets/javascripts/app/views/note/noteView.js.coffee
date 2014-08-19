window.app = window.app or {}

app.NoteView = Backbone.View.extend
  el: '.track'

  initialize: ->
    # _.bindAll(this, 'render')
    # @.collection.bind('change', this.render)
  render: ->
    console.log('note rendered')
    $note = $('<div/>')
    $note.addClass('note')
    $note.css('left', @.model.get('point_in_segment'))
    return $note