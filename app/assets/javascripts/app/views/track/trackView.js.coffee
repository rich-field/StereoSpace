window.app = window.app or {}

app.TrackView = Backbone.View.extend
  tagName: 'div'
  className: 'track'
  # events:

  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    app.track = app.tracks.get('id')
    trackHTML = Handlebars.compile( app.templates.trackView )
    copy = trackHTML( @.model.toJSON() )
    @.$el.append( copy )
    @.$el.draggable( {containment: '#timelines', snap: ".timeline"} )
    @.$el.appendTo('#timelines')
    return @.$el