window.app = window.app or {}

app.NoteView = Backbone.View.extend
  tagName: 'div'
  className: 'note'

  initialize: ->

  render: ->
    @$el.css('left', @.model.get('point_in_segment'))
    return @$el