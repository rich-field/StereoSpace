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

    $seeker = $('<div/>')
    $seeker.addClass('seeker')
    $('#timelines').append($seeker)

    playing = false

    $(document).on 'keydown', (e) ->
      if e.keyCode == 32
        if playing == false# and $('.seeker').css('left') == (window.innerWidth - seekerWidth)
          playing = true
          seekerWidth = parseInt( $('.seeker').css('width') )
          $('.seeker').animate
            left: "#{ window.innerWidth - seekerWidth }", 1000
        else
          playing = false
          $('.seeker').css('left', 0)
          # pause
    $(document).on 'doubleclick', (e) ->
      console.log(e)
