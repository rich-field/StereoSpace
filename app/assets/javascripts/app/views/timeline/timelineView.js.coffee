window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'

  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    # @.$el.html('')
    console.log('Timeline rendered')
    timelineHTML = Handlebars.compile( app.templates.timelineView )
    segments = new app.Segments
    segments.fetch(({data: {timeline_id: @.model.get('id')}})).done =>
      segments.each (model) =>
        segmentView = new app.SegmentView({model: model})
        @.$el.append( segmentView.render() )

    return @.$el