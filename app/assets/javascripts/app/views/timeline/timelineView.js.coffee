window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'
  events:
    'click': 'selectTimeline'
  initialize: ->
    _.bindAll(this, 'render')
    _.bindAll(this, 'keyControls')
    _.bindAll(this, 'deleteTimeline')
    @.model.bind('change', this.render)

    $(document).on 'keydown', (e) =>
      @.keyControls(e)

  render: ->
    timelineHTML = Handlebars.compile( app.templates.timelineView )
    # Fetches segments for this timeline
    segments = new app.Segments
    segments.fetch(({data: {timeline_id: @.model.get('id')}})).done =>
      # Renders each segment for this timeline
      segments.each (model) =>
        segmentView = new app.SegmentView({model: model})
        @.$el.append( segmentView.render() )
    return @.$el

  selectTimeline: (e) ->
    e.stopPropagation()
    $('.selected').removeClass('selected')
    @.$el.toggleClass('selected')
    app.selectedTimeline = @.model
    app.selectedNote = null
    app.selectedSegment = null

  keyControls: (e) ->
    if e.keyCode == 8 and app.selectedTimeline
      e.stopPropagation();
      e.preventDefault()
      @.deleteTimeline()

  deleteTimeline: ->
      $('.timeline.selected').remove()
      app.selectedTimeline.destroy()
      app.selectedTimeline = null
