window.app = window.app or {}

app.SegmentView = Backbone.View.extend
  tagName: 'div'
  className: 'segment'
  events:
    'mouseup' : 'moveTrack'
    'click': 'selectSegment'
  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)
    @.model.collection.bind('add', this.renderNotes)
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
    console.log @.model.collection.length, "notes?"
    @.model.collection.each (model) =>
      noteView = new app.NoteView({model: model})
      @.$el.append( noteView.render() )

  selectSegment: ->
    console.log(@.model)
    console.log('selected')
    @.$el.toggleClass('selected')