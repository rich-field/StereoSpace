window.app = window.app or {}
app.AppView = Backbone.View.extend
  el: '#main'
  initialize: ->
    console.log('appView has been initialized')
    this.render()

  render: ->
    console.log('appView has been rendered')
    @.$el.html( app.templates.appView )