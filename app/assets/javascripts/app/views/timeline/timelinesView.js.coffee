window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: ->
    console.log('TimelinesView has been initialized')
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)
    @.render()

  render: ->
    console.log('TimelinesView has been rendered')
    @.collection.each (model) =>
      console.log(model)
      timelineView = new app.TimelineView(model: model)
      @.$el.append( "la dee da mr frenchman" )
      @.$el.append( timelineView.render() )