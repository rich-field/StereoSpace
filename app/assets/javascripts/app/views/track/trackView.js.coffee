window.app = window.app or {}

app.TrackView = Backbone.View.extend
  tagName: 'div'
  className: 'track'
  # events:

  initialize: ->
    console.log('TrackView has been initialized')
    _.bindAll(this, 'render')
    @.model.mind('change', this.render)


  render: ->
    app.track = app.tracks.get(id)
    trackHTML = Handlebars.compile( app.templates.trackView )
    copy = trackHTML( @.model.toJSON() )
    @.$el.append( copy )
    return @.$el