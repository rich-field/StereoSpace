window.app = window.app or {}

app.NoteView = Backbone.View.extend
  tagName: 'div'
  className: 'note'

  initialize: ->

  render: ->
    console.log @$el.length, "tracks"
    console.log('note rendered')
    # $note = $('<div/>')
    # $note.addClass('note')
    @$el.css('left', @.model.get('point_in_segment'))
    return @$el