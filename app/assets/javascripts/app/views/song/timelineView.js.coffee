window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'

  initialize: ->
    console.log('TimeLine has been initialized')
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    timelineHTML = Handlebars.compile( app.templates.timelineView)
    copy = timelineHTML( @.model.toJSON() )
    @.$el.append( copy )
    return @.$el