window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'

  initialize: ->
    console.log('TimeLine has been initialized')
    _.bindAll(this, 'render')
    @.collection.bind('change', this.render)

  render: ->
    console.log('TimeLine has been rendered')
    timelineHTML = Handlebars.compile( app.templates.timelineView )

    console.log(@.collection)
    @.collection.each (model) =>
      trackView = new app.TrackView({model: model})
      @.$el.append( trackView.render() )

    return @.$el