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
    # FIXME This needs to be an each loop to drop all the tracks on this timeline
    @.collection.each (model) =>
      track = new app.TrackView({model: model})
      # Must pass in the track rendered to the append
      newTrack = track.render()
      newTrack.css('left', track.model.get('start_time') )
      @.$el.append( newTrack )

    return @.$el