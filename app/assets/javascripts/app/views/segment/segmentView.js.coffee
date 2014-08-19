window.app = window.app or {}

app.SegmentView = Backbone.View.extend
  tagName: 'div'
  className: 'segment'
  events:
    'mousedown': 'selectSegment'
    'mouseup' : 'moveTrack'
  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)
    @.renderNotes()

  render: ->    # The model is the specific track passed into the timeline view
    segmentHTML = Handlebars.compile( app.templates.segmentView )
    copy = segmentHTML( @.model.toJSON() )
    @.$el.css('width', @.model.get('duration') + 'px' )
    @.$el.css('left', @.model.get('start_time') + 'px' )
    @.$el.append( copy )

    # To keep track of where the segment is when it's rendered
    @.point_in_timeline = @.$el.css('left')

    # Makes this segment draggable
    @.$el.draggable( {containment: '#timelines', snap: ".timeline"} )

    return @.$el

  moveTrack: ->
    if @.point_in_timeline != @.$el.css('left')
      @.model.save({start_time: parseInt(@.$el.css('left')) })

  renderNotes: ->
    # Clears notes before re rendering notes
    @.$el.html("")
    @.model.attributes.notes.each (model) =>
      noteView = new app.NoteView({model: model})
      @.$el.append( noteView.render() )

  selectSegment: ->
    app.selectedSegment = @.model
    @.$el.toggleClass('selected')