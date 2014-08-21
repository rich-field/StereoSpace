window.app = window.app or {}

app.SongShowView = Backbone.View.extend
  el: '#song'
  events:
    'click #add-timeline': 'addTimeline'
    'click #save-song': 'saveSong'
    'click #rewind': 'rewindSeeker'
    'click #record': 'recordSong'
    'mouseup .seeker': 'repositionSeeker'
  initialize: ->
    # @.model.save()
    $(document).on 'keydown', (e) =>
      # Spacebar controls play/pause
      if e.keyCode == 32 && !app.recording
        @.playSong(e)

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
          app.selectedTimeline = app.selectedTimeline or app.timelines.last()
          app.selectedTimelineView = app.selectedTimelineView or $('.timeline:last')

          # creates new segment
          app.segment = new app.Segment
            timeline_id: app.selectedTimeline.get('id')
            start_time: app.startRecordTime


          app.$segment = $('<div/>')
          app.$segment.css('position', 'absolute')
          app.$segment.css('width', (app.seekerPosition - app.startRecordTime))
          app.$segment.css('left', (app.seekerPosition))
          app.$segment.addClass('segment')
          app.$segment.draggable( {containment: '#timelines', snap: ".timeline", axis: 'x'} )
          app.$segment.appendTo( app.selectedTimelineView )
          app.seekerOnSegment = true

        app.segment.save().done ->
          note = new app.Note
            point_in_segment: ( app.seekerPosition - app.startRecordTime )
            segment_id: app.segment.get('id')
            sample_path: app.soundKeys[e.keyCode]
          note.save().done ->
            $note = $('<div/>')
            $note.addClass('note')
            $note.css('left', (app.seekerPosition - app.startRecordTime) )
            # app.$segment.css('width', (app.startRecordTime + app.seekerPosition))
            $note.appendTo( app.$segment )

  render: ->
    $('#visualizer').html('')
    html = Handlebars.compile( app.templates.songShowView )
    copy = html( this.model.toJSON() )

    # Renders all the timelines this song
    app.timelines = new app.Timelines
    app.timelines.fetch( {data: {song_id: @.model.get('id')}} ).done =>
      timelines = new app.TimelinesView({collection: app.timelines, song: @.model})

    @.$el.html( copy )

    # adds seeker to timelines div
    $seeker = $('<div/>')
    $seeker.addClass('seeker')
    $('#timelines').append($seeker)
    $('.seeker').draggable({axis: 'x', containment: '#timelines'})

  addTimeline: ->
    newTimeline = new app.Timeline({song_id: @.model.get('id')})
    newTimeline.save();
    app.timelines.add(newTimeline);

  saveSong: ->
    @.model.save()

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
          app.source.stop(0) if app.currentSound = app.soundKeys[ app.notesToPlay[app.seekerPosition] ] && app.source
          app.playSound( app.notesToPlay[app.seekerPosition] )
          app.currentSound = app.soundKeys[ app.notesToPlay[app.seekerPosition] ]
        console.log( app.seekerPosition ) if app.notesToPlay[app.seekerPosition]
        $('.seeker').css('left', app.seekerPosition)
      , 1
    else
      app.playing = false
      clearInterval(app.playNotes)

  recordSong: ->
    # To pause bounce animation
    if $('#record').css('-webkit-animation-play-state') == 'running'
      $('#record').css('-webkit-animation-play-state', 'paused')
    else
      $('#record').css('-webkit-animation-play-state', 'running')

    if app.recording
      # To stop recording
      app.recording = false

      clearInterval(app.recordNotes)
      console.log(app.seekerPosition, app.startRecordTime)
      duration = app.seekerPosition - app.startRecordTime
      app.seekerOnSegment = false
      app.startRecordTime = null
      app.$segment = null

      app.segment.save({duration: duration}).done (response) ->
        segmentView = new app.SegmentView({model: app.segment})
        segmentView.render()
        console.log(response,'done')
    else
      # to start recording
      app.seekerOnSegment = false
      app.recording = true
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
