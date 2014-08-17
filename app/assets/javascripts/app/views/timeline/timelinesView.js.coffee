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
      tracks = new app.Tracks
      tracks.fetch({data: {timeline_id: model.get('id')}} ).done =>
        console.log('fetch is done')
        timelineView = new app.TimelineView({collection: tracks})
        console.log(model.get('id'))
        @.$el.append( timelineView.render() )