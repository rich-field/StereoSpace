window.app = window.app or {}

app.SongShowView = Backbone.View.extend
  el: '#song'

  initialize: ->
    @.render

  render: ->
    $('#visualizer').html('')
    html = Handlebars.compile( app.templates.songShowView )
    copy = html( this.model.toJSON() )
    app.tracks.fetch({data: {song_id: @.model.get('id')}} ).done ->
      timelines = new app.TimelinesView({collection: app.tracks})
    @.$el.html( copy )

    $('#add-timeline').on 'click', =>
      newTrack = new app.Track({duration: 5000, song_id: @.model.get('id')})
      newTrack.save();
      app.tracks.add(newTrack);

    $seeker = $('<div/>')
    $seeker.addClass('seeker')
    $('#timelines').append($seeker)

    $(document).on 'keydown', (e) ->

      playing = false

      if e.keyCode == 32
        if playing == false
          playing = true
          seekerWidth = parseInt( $('.seeker').css('width') )
          $('.seeker').animate
            left: "#{window.innerWidth - seekerWidth }", 1000
        # else
          # pause


        console.log('WHY DO YOU FUCK WITH ME LIKE THIS.. WHY!')

