window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: (options) ->
    _.bindAll(this, 'render')
    @.collection.bind('add', this.renderOne)
    @.song = options.song
    @.render()

  render: ->
    # @.$el.html('')
    # Renders a single timeline and then
    console.log('Timelines rendered')
    @.collection.each (model) =>
      # segments = new app.Segments
      # segments.fetch( {data: {timeline_id: model.get('id')}} ).done =>
      timelineView = new app.TimelineView({model: model})
      @.$el.append( timelineView.render() )
        # timelineView = new app.TimelineView({collection: segments})
        # @.$el.append( timelineView.render() )
    # console.log( @.$el.css('width') )
    # console.log( @.song.get('duration') )g
    @.$el.css('width', @.song.get('duration') + 'px')
  renderOne: (view, collection, event)->
    timeline = collection.last()
    timelineView = new app.TimelineView({model: timeline})

