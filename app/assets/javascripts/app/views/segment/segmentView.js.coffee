window.app = window.app or {}

app.SegmentView = Backbone.View.extend
  tagName: 'div'
  className: 'segment'
  events:
    'click': 'selectSegment'
    'mouseup' : 'moveTrack'
  initialize: ->
    _.bindAll(this, 'render')
    _.bindAll(this, 'keyControls')
    _.bindAll(this, 'deleteSegment')
    _.bindAll(this, 'renderNotes')
    @.model.bind('change', this.render)
    @.model.bind('change', this.renderNotes)
    @.renderNotes()

    $(document).on 'keydown', (e) =>
      @.keyControls(e)

  render: ->    # The model is the specific track passed into the timeline view
    segmentHTML = Handlebars.compile( app.templates.segmentView )
    copy = segmentHTML( @.model.toJSON() )
    @.$el.css('width', @.model.get('duration')/4 + 'px' )
    @.$el.css('left', @.model.get('start_time') + 'px' )
    @.$el.append( copy )

    # To keep track of where the segment is when it's rendered
    @.point_in_timeline = @.$el.css('left')

    # Makes this segment draggable
    @.$el.draggable( {containment: '#timelines', snap: ".timeline"} )
    return @.$el

  moveTrack: ->
    # Checks if the left position has moved and saves the model
    if @.point_in_timeline != @.$el.css('left')
      @.model.save({start_time: parseInt(@.$el.css('left')) })

  renderNotes: ->
    # Clears notes before re rendering
    @.$el.html("")
    # Sets the notesToPlay object to itself if it exists, otherwise make a new object
    app.notesToPlay = app.notesToPlay or {}
    @.model.attributes.notes.each (model) =>
      # populates the app.notesToPlay object
      app.notesToPlay[( @.model.get('start_time') + model.get('point_in_segment') )] = model.get('sample_path').replace(".wav","").replace("/audios/", "")
      console.log(app.notesToPlay)
      # creates a view for the note
      noteView = new app.NoteView({model: model})
      @.$el.append( noteView.render() )

  selectSegment: (e) ->
    # Prevent the event propogating to parent
    e.stopPropagation()
    $('.segment.selected').removeClass('selected')
    @.$el.addClass('selected')
    app.selectedSegment = @.model
    app.selectedTimeline = null

  keyControls: (e) ->
    if e.keyCode == 8 and app.selectedSegment
      e.stopPropagation()
      e.preventDefault()
      @.deleteSegment()
    else if app.soundKeys[e.keyCode] && app.recording
      console.log('key in sound')

  deleteSegment: ->
    ## FIXME Need to re-get the notes for this song and repopulate app.notes
    $('.segment.selected').remove()
    app.selectedSegment.destroy()
    app.selectedSegment = null