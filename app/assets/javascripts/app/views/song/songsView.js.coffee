window.app = window.app or {}
app.SongsView = Backbone.View.extend
  el: '#visualizer'
  initialize: ->
    console.log('SongsView has been initialized')
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)
  render: ->
    console.log('SongsView has been rendered')
    songsTemplate = Handlebars.compile( app.templates.songsView )

    viewAll = this

    @.collection.each (model) ->
      console.log(model)
      songView = new app.SongView(model: model)
      viewAll.$el.append( songView.render() )

