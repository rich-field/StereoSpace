window.app = window.app or {}

app.SongShowView = Backbone.View.extend
  el: '#song'

  initialize: ->
    @.render

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
          seekerWidth = parseInt( $('.seeker').css('width') )
          timelineWidth = parseInt( $('#timelines').css('width') )
          $('.seeker').animate
            left: "#{ ( timelineWidth - seekerWidth) }", @.model.get('duration'), 'linear'

          setInterval ->
            app.seekerPosition = $('.seeker').css('left')
            # console.log app.seekerPosition
          , 10
        else
          app.playing = false
          # $('.seeker').css('left', 0)
          $('.seeker').stop()
          console.log('Pause')
          # pause

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