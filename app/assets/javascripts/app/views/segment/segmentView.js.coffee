window.app = window.app or {}

app.SegmentView = Backbone.View.extend
  tagName: 'div'
  className: 'segment'

  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->    # The model is the specific track passed into the timeline view
    console.log('Segment rendered')
    segmentHTML = Handlebars.compile( app.templates.segmentView )
    copy = segmentHTML( @.model.toJSON() )
    @.$el.css('width', @.model.get('duration') )
    @.$el.css('left', @.model.get('start_time') )
    @.$el.append( copy )
    @.$el.draggable( {containment: '#timelines', snap: ".timeline"} )
    return @.$el