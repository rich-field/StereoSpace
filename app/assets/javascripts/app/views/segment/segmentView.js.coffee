window.app = window.app or {}

app.SegmentView = Backbone.View.extend
  tagName: 'div'
  className: 'segment'
  events:
    'mouseup' : 'moveTrack'
  initialize: ->
    _.bindAll(this, 'render')
    console.log(@.model.collection)
    console.log('supposed to be notes above me')
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

    console.log(@.model.get('id'))
    console.log(@.$el.css('left'))
    console.log('You stopped dragging me')
  renderNotes: ->
    # Clears notes before re rendering notes
    @.$el.html("")
    @.model.collection.each (model) =>
      noteView = new app.NoteView({model: model})
      @.$el.append( noteView.render() )