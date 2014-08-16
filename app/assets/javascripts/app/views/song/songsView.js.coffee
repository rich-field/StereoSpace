window.app = window.app or {}
app.SongsView = Backbone.View.extend
  el: '#visualizer'
  initialize: ->
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)
  render: ->
    songsTemplate = Handlebars.compile( app.templates.songsView )
    @.$el.html( songsTemplate )
    viewAll = this
    @.collection.each (model) ->
      songView = new app.SongView(model: model)
      viewAll.$el.append( songView.render() )

