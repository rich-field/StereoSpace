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
    notes = new app.Notes
    notes.fetch({data: {segment_id: @.model.get('id')}}).done =>
      notes.each (model) =>
        noteView = new app.NoteView({model: model})
        @.$el.append( noteView.render() )
    return @.$el