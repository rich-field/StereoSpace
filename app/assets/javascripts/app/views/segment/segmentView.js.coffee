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
    @.model.bind('change', this.render)
    # @.model.bind('change', this.renderNotes)
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
    # Clears notes before re rendering notes
    @.$el.html("")
    @.model.attributes.notes.each (model) =>
      noteView = new app.NoteView({model: model})
      @.$el.append( noteView.render() )

  selectSegment: ->

    # $('.segment.selected').removeClass('selected')
    # console.log('toggle class in segment')
    # @.$el.toggleClass('selected')
    # app.selectedSegment = @.model

    # $('.timeline .selected').removeClass('selected')
    # app.selectedTimeline = null

  keyControls: (e) ->
    if e.keyCode == 8 and app.selectedSegment
      e.stopPropagation()
      e.preventDefault()
      @.deleteSegment()

  deleteSegment: ->
    $('.segment.selected').remove()
    app.selectedSegment.destroy()
    app.selectedSegment = null