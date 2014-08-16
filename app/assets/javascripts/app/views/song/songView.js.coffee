window.app = window.app or {}
app.SongView = Backbone.View.extend
  tagName: 'div'
  className: 'song-in-list'

  initialize: ->
    console.log('SongView has been initialized')
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    console.log('songView has been rendered')
    songHTML = Handlebars.compile( app.templates.songView )
    copy = songHTML( @.model.toJSON )
    @.$el.append( copy )
    return @.$el

