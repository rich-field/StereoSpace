window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'

  initialize: ->
    _.bindAll(this, 'render')
    @.collection.bind('change', this.render)

  render: ->
    @.$el.html('')
    timelineHTML = Handlebars.compile( app.templates.timelineView )
    @.collection.each (model) =>
      segmentView = new app.SegmentView({model: model})
      @.$el.append( segmentView.render() )

    return @.$el