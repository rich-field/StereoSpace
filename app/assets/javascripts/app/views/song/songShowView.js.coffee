# Namespace
window.app = window.app or {}

# Creates a constructor for a single songs "show" page
# This expects a song to be passed in
app.SongShowView = Backbone.View.extend
  el: '#song'
  events:
    'mouseup .seeker': 'repositionSeeker'
  initialize: ->
    # To deselect the selected elements
    $(document).on 'click', (e) =>
      e.stopPropagation()
      if !$(e.target).hasClass('timeline') && !$(e.target).is('#record')
        $('.timeline.selected').removeClass('selected')
        app.selectedTimeline = null

      if !$(e.target).hasClass('segment')
        $('.segment.selected').removeClass('selected')
        app.selectedSegment = null

      if !$(e.target).hasClass('note')
        $('.note.selected').removeClass('selected')
        app.selectedNote = null
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

  render: ->
    $('#visualizer').html('')
    html = Handlebars.compile( app.templates.songShowView )
    copy = html( this.model.toJSON() )

    @model.renderTimelines()

    @.$el.html( copy )

    $('#hide-timelines').on 'click', =>
      $('#timelines-outer').fadeToggle();

    $(document).on 'keydown', (e) =>
      # Spacebar controls play/pause
      if e.keyCode == 32 && !app.recording
        @model.playSong()

  repositionSeeker: ->
    app.seekerPosition = parseInt( $('.seeker').css('left') )
