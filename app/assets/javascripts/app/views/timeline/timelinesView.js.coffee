window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: (options) ->
    _.bindAll(this, 'render')
    @.collection.bind('add', this.renderOne)
    @.song = options.song
    @.render()

  render: ->
    # Renders a single timeline and then
    console.log('Timelines rendered')
    @.collection.each (model) =>
      timelineView = new app.TimelineView({model: model})
      @.$el.append( timelineView.render() )
    @.$el.css('width', @.song.get('duration') + 'px')

  renderOne: (view, collection, event) =>
    timeline = collection.last()
    timelineView = new app.TimelineView({model: timeline})
    # debugger
    @.$el.append( timelineView.render() )

