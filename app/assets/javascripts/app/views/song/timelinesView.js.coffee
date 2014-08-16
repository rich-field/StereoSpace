window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: ->
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)

  render: ->
    @.collection.each (model) =>
      timelineView = new app.TimelineView(model: model)
      viewAll.$el.append( timelineView.render() )