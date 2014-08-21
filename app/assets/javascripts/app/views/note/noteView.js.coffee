window.app = window.app or {}

app.NoteView = Backbone.View.extend
  tagName: 'div'
  className: 'note'
  events:
    'click': 'selectNote'
    'keydown': 'keyControls'

  initialize: ->

    _.bindAll(this, 'keyControls')
    _.bindAll(this, 'deleteNote')

    $(document).on 'keydown', (e) =>
      @.keyControls(e)

  render: ->
    @.$el.css('left', @.model.get('point_in_segment'))
    return @$el

  selectNote: (e) ->
    e.stopPropagation()
    $('.selected').removeClass('selected')
    @.$el.toggleClass('selected')
    app.selectedNote = @.model
    app.selectedTimelime = null
    app.selectedSegment = null

  keyControls: (e) ->
    if e.keyCode == 8 and app.selectedNote
      e.stopPropagation()
      e.preventDefault()
      @.deleteNote()

  deleteNote: ->
    $('.note.selected').remove()
    app.selectedNote.destroy()
    app.selectedNote = null
    app.notes.fetch().done ->