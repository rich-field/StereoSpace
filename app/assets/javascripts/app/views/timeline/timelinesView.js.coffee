window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: ->
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)
    @.render()

  render: ->

    # Renders a single timeline and then
    @.collection.each (model) =>
      app.tracks = new app.Tracks
      app.tracks.fetch({data: {timeline_id: model.get('id')}} ).done =>
        timelineView = new app.TimelineView({collection: app.tracks})
        @.$el.append( timelineView.render() )