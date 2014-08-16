window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: ->
    console.log('TimelinesView has been initialized')
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)

  render: ->
    console.log('TimelinesView has been rendered')
    @.collection.each (model) =>
      timelineView = new app.TimelineView(model: model)
      @.$el.append( timelineView.render() )