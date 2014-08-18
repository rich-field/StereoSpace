window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'

  initialize: ->
    _.bindAll(this, 'render')
    @.collection.bind('change', this.render)

  render: ->
    timelineHTML = Handlebars.compile( app.templates.timelineView )
    @.collection.each (model) =>
      trackView = new app.TrackView({model: model})
      @.$el.append( trackView.render() )

    return @.$el