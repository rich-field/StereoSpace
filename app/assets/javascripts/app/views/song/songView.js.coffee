window.app = window.app or {}
app.SongView = Backbone.View.extend
  tagName: 'div'
  className: 'song-in-list'
  events:
    'click': 'view'


  initialize: ->
    console.log('SongView has been initialized')
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    songHTML = Handlebars.compile( app.templates.songView )
    copy = songHTML( @.model.toJSON() )
    @.$el.append( copy )
    return @.$el

  view: ->
    app.router.navigate("songs/#{@.model.get('id')}", true)

