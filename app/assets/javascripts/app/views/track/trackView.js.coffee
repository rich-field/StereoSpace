window.app = window.app or {}

app.TrackView = Backbone.View.extend
  tagName: 'div'
  className: 'track'

  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    track = app.tracks.get('id')
    trackHTML = Handlebars.compile( app.templates.trackView )
    copy = trackHTML( @.model.toJSON() )
    @.$el.css('left', @.model.get('start_time') )
    @.$el.append( copy )
    @.$el.draggable( {containment: '#timelines', snap: ".timeline"} )
    return @.$el