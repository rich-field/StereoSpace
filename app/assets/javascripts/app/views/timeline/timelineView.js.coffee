window.app = window.app or {}

app.TimelineView = Backbone.View.extend
  tagName: 'div'
  className: 'timeline'

  initialize: ->
    console.log('TimeLine has been initialized')
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    console.log('TimeLine has been rendered')
    timelineHTML = Handlebars.compile( app.templates.timelineView )


    # FIXME This needs to be an each loop to drop all the tracks on this timeline
    track = new app.TrackView({model: @.model})
    # Must pass in the track rendered to the append
    @.$el.append( track.render() )

    return @.$el