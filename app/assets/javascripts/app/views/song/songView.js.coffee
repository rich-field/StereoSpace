# Namespace
window.app = window.app or {}

# Creates a constructor for a song in the songlist view
# Expects a single song model to be passed in {model: song}
app.SongView = Backbone.View.extend
  tagName: 'div'
  className: 'song-in-list'
  events:
    'click': 'view'


  initialize: ->
    _.bindAll(this, 'render')
    @.model.bind('change', this.render)

  render: ->
    songHTML = Handlebars.compile( app.templates.songView )
    copy = songHTML( @.model.toJSON() )
    @.$el.append( copy )
    return @.$el

  # Navigates to apropos song view page when you click this div
  view: ->
    app.router.navigate("songs/#{@.model.get('share_url')}", true)

