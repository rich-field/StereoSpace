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

