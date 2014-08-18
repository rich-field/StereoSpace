window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: (options) ->
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)
    @.song = options.song
    @.render()

  render: ->
    # Renders a single timeline and then
    @.collection.each (model) =>
      tracks = new app.Tracks
      tracks.fetch( {data: {timeline_id: model.get('id')}} ).done =>
        console.log(tracks)
        timelineView = new app.TimelineView({collection: tracks})
        @.$el.append( timelineView.render() )
    # console.log( @.$el.css('width') )
    # console.log( @.song.get('duration') )
    @.$el.css('width', @.song.get('duration') + 'px')
