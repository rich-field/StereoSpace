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

    $('#close-hello').on 'click', ->
      $('#hello').fadeOut ->
        $('#hello').remove()

    $('#play').on 'click', =>
      @playSong()

    $('#record').on 'click', =>
      @recordSong()

    $('#rewind').on 'click', =>
      @rewindSeeker()

    $('#add-timeline').on 'click', =>
      @addTimeline()

  render: ->
    $('#visualizer').html('')
    html = Handlebars.compile( app.templates.songShowView )
    copy = html( this.model.toJSON() )

    @.renderTimelines()

    @.$el.html( copy )

    $('#hide-timelines').on 'click', =>
      $('#timelines-outer').fadeToggle();

    $(document).on 'keydown', (e) =>
      # Spacebar controls play/pause
      if e.keyCode == 32 && !app.recording
        @.playSong(e)

    # @.renderSeeker()

  renderTimelines: ->
    # Renders all the timelines this song
    app.timelines = new app.Timelines
    app.timelines.fetch( {data: {song_id: @.model.get('id')}} ).done =>
      timelines = new app.TimelinesView({collection: app.timelines, song: @.model})
      # @.renderSeeker()

  renderSeeker: ->
    # adds seeker to timelines div
    $seeker = $('<div/>')
    .addClass('seeker')
    .draggable({axis: 'x', containment: '#timelines'})
    .css('position', 'absolute')
    .css('top', 0)
    .css('left', app.seekerPosition)
    .appendTo( $('#timelines') )

  addTimeline: ->
    newTimeline = new app.Timeline({song_id: @.model.get('id')})
    newTimeline.save();
    app.timelines.add(newTimeline);

  rewindSeeker: ->
    # reset seeker position
    app.seekerPosition = 0
    $('.seeker').css('left', '0px')

  playSong: ->
    # SEEKER PLAY
    if app.playing == false
      app.playing = true
      app.playNotes = setInterval ->
        app.seekerPosition++
        if app.notesToPlay[app.seekerPosition]
          app.source.stop(0) if app.currentSound = app.notesToPlay[app.seekerPosition] && app.source
          app.playSound( app.notesToPlay[app.seekerPosition] )
          app.currentSound = app.notesToPlay[app.seekerPosition]
        console.log( app.seekerPosition ) if app.notesToPlay[app.seekerPosition]
        $('.seeker').css('left', app.seekerPosition)
      , 1
    else
      app.playing = false
      clearInterval(app.playNotes)

  recordSong: ->
    if app.recording
      # To stop recording
      app.recording = false
      $recordSvg = $("<img src='/assets/icon-01.svg' class='svg-icon'>")
      $('#record').html( $recordSvg )

      clearInterval(app.recordNotes)
      duration = app.seekerPosition - app.startRecordTime
      app.seekerOnSegment = false
      app.startRecordTime = null
      app.$segment = null
      # re-render the timelines
      app.segment.save({duration: duration}).done (response) =>
        app.notesToPlay = {}
        @.renderTimelines()
    else
      # to start recording
      app.seekerOnSegment = false
      app.recording = true

      $stopSvg = $("<img src='/assets/icon-02.svg' class='svg-icon'>")
      $('#record').html( $stopSvg )
      console.log(app.notesToPlay)
      app.recordNotes = setInterval ->
        app.seekerPosition++
        # sets the start record time on the first key down
        app.$segment.css("width", "+=1") if app.$segment
        app.playSound( app.notesToPlay[app.seekerPosition] ) if app.notesToPlay[app.seekerPosition]
        $('.seeker').css('left', app.seekerPosition)
      , 1

  repositionSeeker: ->
    app.seekerPosition = parseInt( $('.seeker').css('left') )
