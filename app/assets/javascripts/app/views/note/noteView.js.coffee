# Namespacing
window.app = window.app or {}

# Instantiates a constructor for a single note view within a segment.
# Expects a note to be passed in {model: note}
app.NoteView = Backbone.View.extend
  # Creates a new <div> with the classname .note
  tagName: 'div'
  className: 'note'
  # Listens for click and keydown events, sending them to functions within this constructor
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