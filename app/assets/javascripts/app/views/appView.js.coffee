window.app = window.app or {}
app.AppView = Backbone.View.extend
  el: '#main'
  initialize: ->
    # this.render()

  render: ->
    @.$el.html( app.templates.appView )