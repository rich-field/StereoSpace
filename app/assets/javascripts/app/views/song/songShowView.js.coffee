window.app = window.app or {}

app.SongShowView = Backbone.View.extend
  el: '#song'
  events:
    'click #add-timeline': 'addTimeline'
    'click #save-song': 'saveSong'
    'click #rewind': 'rewindSeeker'
    'click #record': 'recordSong'

  initialize: ->
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

    # SEEKER PLAY
    app.playing = false # Init app.playing to be false

  addTimeline: ->
      newTimeline = new app.Timeline({song_id: @.model.get('id')})
      newTimeline.save();
      app.timelines.add(newTimeline);

  saveSong: ->
    @.model.save()

  rewindSeeker: ->
    app.seekerPosition = 0
    $('.seeker').css('left', '0px')

  playSong: ->
    if app.playing == false
      app.playing = true
      app.playNotes = setInterval ->
        app.seekerPosition++
        app.playSound( app.notesToPlay[app.seekerPosition] ) if app.notesToPlay[app.seekerPosition]
        $('.seeker').css('left', app.seekerPosition * 1.7)
      , 1
    else
      app.playing = false
      clearInterval(app.playNotes)

  recordSong: ->
    if app.recording
      app.recording = false
      console.log('stop record')

      clearInterval(app.recordNotes)
      console.log(app.seekerPosition, app.startRecordTime)
      duration = app.seekerPosition - app.startRecordTime

      app.segment.save({duration: duration}).done (response) ->
        segmentView = new app.SegmentView({model: app.segment})
        segmentView.render()
        app.seekerOnSegment = false
        console.log(response,'done')
    else
      app.seekerOnSegment = false
      app.recording = true
      console.log('record')
      console.log(app.notesToPlay)

      app.recordNotes = setInterval ->
        app.seekerPosition++
        # sets the start record time on the first key down
        $(document).on 'keydown', (e) ->
          # Will only run if there is a soundboard key
          if app.soundKeys[e.keyCode]
            app.startRecordTime = app.seekerPosition unless app.startRecordTime

            unless app.seekerOnSegment
              app.segment = new app.Segment
                timeline_id: app.selectedTimeline.get('id')
                start_time: app.startRecordTime
              app.segment.save()
              app.seekerOnSegment = true

            app.notesToPlay[ app.seekerPosition ] = app.soundKeys[e.keyCode]
            note = new app.Note
              point_in_segment: (app.startRecordTime + app.seekerPosition)
              segment_id: app.segment.get('id')
              sample_path: "/audios/#{app.soundKeys[e.keyCode]}.wav"
            note.save()

        app.playSound( app.notesToPlay[app.seekerPosition] ) if app.notesToPlay[app.seekerPosition]
        $('.seeker').css('left', app.seekerPosition * 1.7)
      , 1
