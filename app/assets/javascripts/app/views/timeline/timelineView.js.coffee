window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'
  events:
    'click': 'selectTimeline'
  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

    $(document).on 'keydown', (e) =>
      @.keyControls(e)

  render: ->
    timelineHTML = Handlebars.compile( app.templates.timelineView )
    segments = new app.Segments
    segments.fetch(({data: {timeline_id: @.model.get('id')}})).done =>
      segments.each (model) =>
        segmentView = new app.SegmentView({model: model})
        @.$el.append( segmentView.render() )

    return @.$el
  selectTimeline: ->
    $('.selected').toggleClass('selected')
    @.$el.toggleClass('selected')
    app.selectedTimeline = @.model

  keyControls: (e) ->

    if e.keyCode == 8 and app.selectedTimeline
      e.stopPropagation();
      e.preventDefault()
      $('.timeline.selected').remove()
      app.selectedTimeline.destroy()
      app.selectedTimeline = null