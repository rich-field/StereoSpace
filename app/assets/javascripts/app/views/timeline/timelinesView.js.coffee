window.app = window.app or {}

app.TimelinesView = Backbone.View.extend
  el: '#timelines'

  initialize: (options) ->
    _.bindAll(this, 'render')
    _.bindAll(this, 'renderOne')
    @.collection.bind('add', this.render)
    @.song = options.song
    @.render()

  render: ->
    @.$el.html('')
    # Renders each timeline in this song
    @.collection.each (model) =>
      timelineView = new app.TimelineView({model: model})
      @.$el.append( timelineView.render() )
    @.$el.css('width', @.song.get('duration') + 'px')

    @.renderSeeker()

  renderOne: (view, collection, event) ->
    timeline = collection.last()
    timelineView = new app.TimelineView({model: timeline})
    @.$el.append( timelineView.render() )

  renderSeeker: ->
    # adds seeker to timelines div
    $seeker = $('<div/>')
    .addClass('seeker')
    .draggable({axis: 'x', containment: '#timelines'})
    .css('position', 'absolute')
    .css('top', 0)
    .css('left', app.seekerPosition)
    .appendTo( $('#timelines') )