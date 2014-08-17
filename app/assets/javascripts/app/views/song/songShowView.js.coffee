window.app = window.app or {}

app.SongShowView = Backbone.View.extend
  el: '#song'

  initialize: ->
    @.render

  render: ->
    $('#visualizer').html('')
    html = Handlebars.compile( app.templates.songShowView )
    copy = html( this.model.toJSON() )

    app.timelines = new app.Timelines
    app.timelines.fetch( {data: {song_id: @.model.get('id')}} ).done ->
      timelines = new app.TimelinesView({collection: app.timelines})
    @.$el.html( copy )

    $('#add-timeline').on 'click', =>
      newTimeline = new app.Timeline({song_id: @.model.get('id')})
      newTimeline.save();
      app.timelines.add(newTimeline);

    $('#save-song').on 'click', =>
      @.model.save()

    $seeker = $('<div/>')
    $seeker.addClass('seeker')
    $('#timelines').append($seeker)

    $(document).on 'keydown', (e) ->

      playing = false

      if e.keyCode == 32
        if playing == false# and $('.seeker').css('left') == (window.innerWidth - seekerWidth)
          playing = true
          seekerWidth = parseInt( $('.seeker').css('width') )
          $('.seeker').animate
            left: "#{ window.innerWidth - seekerWidth }", 1000
        else
          playing = false
          # $('.seeker').css('left', 0)
          # pause

