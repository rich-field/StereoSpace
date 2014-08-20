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
      if app.recording
        app.recording = false
      else
        app.recording = true

    # adds seeker to timelines div
    $seeker = $('<div/>')
    $seeker.addClass('seeker')
    $('#timelines').append($seeker)
    $('.seeker').draggable({axis: 'x', containment: '#timelines'})



    # SEEKER PLAY
    app.playing = false # Init app.playing to be false

    $(document).on 'keydown', (e) =>
      if e.keyCode == 32
        if app.playing == false
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