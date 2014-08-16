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
    $('#visualiser').html()
    @.$el.html( copy )

