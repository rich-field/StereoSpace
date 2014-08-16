window.app = window.app or {}

app.SongShowView = Backbone.View.extend
  el: '#song'

  initialize: ->
    console.log('songShowView has been initialized')
    @.render

  render: ->
    console.log( 'this is the songShowView being rendered'  )
    html = Handlebars.compile( app.templates.songShowView )
    copy = html( this.model.toJSON() )
    app.tracks.fetch({data: {song_id: @.model.get('id')}} ).done ->
      timelines = new app.TimelinesView({collection: app.tracks})
    $('#visualiser').html()
    @.$el.html( copy )

