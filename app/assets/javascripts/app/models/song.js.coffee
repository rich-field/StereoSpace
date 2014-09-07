window.app = window.app or {}
app.Song = Backbone.Model.extend
  urlRoot: "/songs"
  renderSeeker: ->
    # adds seeker to timelines div
    $seeker = $('<div/>')
    .addClass('seeker')
    .draggable({axis: 'x', containment: '#timelines'})
    .css('position', 'absolute')
    .css('top', 0)
    .css('left', app.seekerPosition)
    .appendTo( $('#timelines') )

  rewindSeeker: ->
    # reset seeker position
    app.seekerPosition = 0
    $('.seeker').css('left', '0px')

  controlEvents: ->
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

  addTimeline: ->
    newTimeline = new app.Timeline({song_id: @.get('id')})
    newTimeline.save();
    app.timelines.add(newTimeline);

  renderTimelines: ->
    # Renders all the timelines this song
    app.timelines = new app.Timelines
    app.timelines.fetch( {data: {song_id: @get('id')}} ).done =>
      timelines = new app.TimelinesView({collection: app.timelines, song: @})

