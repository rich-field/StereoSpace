window.app = window.app or {}

app.SongShowView = Backbone.View.extend
  el: '#song'

  initialize: ->
    @.render
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


    # EVENTS

    $('#add-timeline').on 'click', =>
      newTimeline = new app.Timeline({song_id: @.model.get('id')})
      newTimeline.save();
      app.timelines.add(newTimeline);

    $('#save-song').on 'click', =>
      @.model.save()

    $('#record').on 'click', =>
      # unless app.playing
      if app.recording
        console.log('stop recording')
        app.recording = false

        clearInterval(app.recordNotes)
        console.log(app.seekerPosition, app.startRecordTime)
        app.segment.save({duration: (app.seekerPosition + app.startRecordTime)}).done (response) ->
          segmentView = new app.SegmentView({model: app.segment})
          segmentView.render()
          app.seekerOnSegment = false
          console.log(response,'done')
      else
        app.recording = true
        console.log('record')
        console.log(app.notesToPlay)

        app.recordNotes = setInterval ->
          app.seekerPosition++
          # app.seekerOnSegment
          # sets the start record time on the first key down
          $(document).on 'keydown', (e) ->
            # Will only run if there is a soundboard key
            if app.soundKeys[e.keyCode]
              app.startRecordTime = app.seekerPosition unless app.startRecordTime

              unless app.seekerOnSegment
                app.segment = new app.Segment
                  timeline_id: app.selectedTimeline
                  start_time: app.startRecordTime
                app.seekerOnSegment = true

              app.notesToPlay[ app.seekerPosition ] = app.soundKeys[e.keyCode]
              note = new app.Note
                point_in_segment: app.startRecordTime + app.seekerPosition
                segment_id: app.segment.get('id')
                sample_path: "/audios/#{app.soundKeys[e.keyCode]}.wav"

          app.playSound( app.notesToPlay[app.seekerPosition] ) if app.notesToPlay[app.seekerPosition]
          $('.seeker').css('left', app.seekerPosition * 1.7)
        , 1


    # adds seeker to timelines div
    $seeker = $('<div/>')
    $seeker.addClass('seeker')
    $('#timelines').append($seeker)
    $('.seeker').draggable({axis: 'x', containment: '#timelines'})



    # SEEKER PLAY
    app.playing = false # Init app.playing to be false

    $(document).on 'keydown', (e) =>
      # Spacebar controls play/pause
      if e.keyCode == 32 && !app.recording
        if app.playing == false
          # seekerPosition = 0
          console.log('Play')
          app.playing = true
          app.playNotes = setInterval ->
            app.seekerPosition++
            app.playSound( app.notesToPlay[app.seekerPosition] ) if app.notesToPlay[app.seekerPosition]
            $('.seeker').css('left', app.seekerPosition * 1.7)
          , 1
        else
          app.playing = false
          clearInterval(app.playNotes)
          console.log('Pause')


    # To deselect the selected elements
    $(document).on 'click', (e) =>
      e.stopPropagation()
      if !$(e.target).hasClass('timeline')
        $('.timeline.selected').removeClass('selected')
        app.selectedTimeline = null

      if !$(e.target).hasClass('segment')
        $('.segment.selected').removeClass('selected')
        app.selectedSegment = null

      if !$(e.target).hasClass('note')
        $('.note.selected').removeClass('selected')
        app.selectedNote = null