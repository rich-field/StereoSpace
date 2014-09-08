# Namespace
window.app = window.app or {}

# Creates a constructor for a single songs "show" page
# This expects a song to be passed in
app.SongShowView = Backbone.View.extend
  el: '#song'
  events:
    'mouseup .seeker': 'repositionSeeker'
  initialize: ->
    # clears the notes to play when you get to a different song view
    app.notesToPlay = {}

    $(document).on 'keydown', (e) ->
      # Will only run if the key pressed is a soundboard key and the app is recording
      if app.soundKeys[e.keyCode] && app.recording
        app.startRecordTime = app.seekerPosition unless app.startRecordTime

        app.notesToPlay[ app.seekerPosition ] = app.soundKeys[ e.keyCode ]

        unless app.seekerOnSegment
          # makes sure the segment is being recorded and appended to a timeline div
          app.selectedTimelineView = if app.selectedTimeline then app.selectedTimelineView else $('.timeline:last')
          app.selectedTimeline = app.selectedTimeline or app.timelines.last()

          # creates new segment
          app.segment = new app.Segment
            timeline_id: app.selectedTimeline.get('id')
            start_time: app.startRecordTime

          # Creates the DOM segment live, chaining
          app.$segment = $('<div/>')
          .css('position', 'absolute')
          .css('width', (app.seekerPosition - app.startRecordTime))
          .css('left', (app.seekerPosition))
          .addClass('segment')
          .draggable( {containment: '#timelines', snap: ".timeline", axis: 'x'} )
          .appendTo( app.selectedTimelineView )

          app.seekerOnSegment = true

        app.segment.save().done ->
          note = new app.Note
            point_in_segment: ( app.seekerPosition - app.startRecordTime )
            segment_id: app.segment.get('id')
            sample_path: app.soundKeys[e.keyCode]
          note.save().done ->
            $note = $('<div/>')
            .addClass('note')
            .css('left', (app.seekerPosition - app.startRecordTime) )
            .appendTo( app.$segment )

    @model.controlEvents()
    @model.selectEvents()

  render: ->
    $('#visualizer').html('')
    html = Handlebars.compile( app.templates.songShowView )
    copy = html( this.model.toJSON() )

    @model.renderTimelines()

    @.$el.html( copy )
    @visual()

  repositionSeeker: ->
    app.seekerPosition = parseInt( $('.seeker').css('left') )

  visual: ->
    # elem = $("#visualizer")[0]
    # visHeight = parseInt( $("#visualizer").css('height') )
    # visWidth = parseInt( $("#visualizer").css('width') )

    # app.two = new Two(
    #   width: visWidth
    #   height: visHeight
    # ).appendTo(elem)

    # # app.curve = app.two.makePolygon(0, app.two.height/2, 120, 50, 140, 150, 160, 50, 180, 150, app.two.width, app.two.height/2,  true);
    # app.curve = app.two.makePolygon(
    #         0, visHeight/2,
    #         # visWidth/8, 500,
    #         # visWidth/4, 400,
    #         visWidth/2, 0,
    #         # visWidth/.5, 109,
    #         visWidth, visHeight/2,
    #         true)
    # app.curve.linewidth = 3
    # app.curve.scale = 2.75
    # app.curve.stroke = '#fff'
    # # curve.rotation = Math.PI / 1 # Quarter-turn
    # app.curve.noFill()
    # app.curve.translation.set app.two.width / 2, app.two.height / 2
    # console.log('twojs made')
    # app.circle = app.two.makeCircle(visWidth/2, visHeight/2, 50)
    # app.circle.fill = "#FF8000"
    # app.circle.stroke = "orangered"

    # curve2 = two.makeCurve(
    #     0, visHeight/2,
    #     # visWidth/8, 500,
    #     # visWidth/4, 200,
    #     visWidth/2, (visHeight/2 - 40),
    #     # visWidth/.5, 109,
    #     visWidth, visHeight/2,
    #     true)
    # curve2.linewidth = 3
    # curve2.scale = 2.75
    # curve2.stroke = '#fff'
    # curve2.noFill()

    # # Groups can take an array of shapes and/or groups.
    # group = two.makeGroup(circle, curve)

    # # And have translation, rotation, scale like all shapes.
    # group.translation.set two.width / 2, two.height / 2
    # group.rotation = Math.PI
    # group.scale = 0.75

    # # You can also set the same properties a shape have.
    # group.linewidth = 7
    app.two.update()
