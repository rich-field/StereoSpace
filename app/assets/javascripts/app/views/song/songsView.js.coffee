window.app = window.app or {}
app.SongsView = Backbone.View.extend
  el: '#visualizer'
  initialize: ->
    console.log('SongsView has been initialized')
    _.bindAll(this, 'render')
    this.collection.bind('add', this.render)
    @.render()
  render: ->
    console.log('SongsView has been rendered')
    songsTemplate = Handlebars.compile( app.templates.songsView )

    Handlebars.registerHelper "list", (items, options) ->
      out = "<ul>"
      i = 0
      l = items.length

      while i < l
        out = out + "<li>" + options.fn(items[i]) + "</li>"
        i++
      out + "</ul>"

    # @.$el.html("hello")

