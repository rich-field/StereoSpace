window.app = window.app or {}
app.Tracks = Backbone.Collection.extend
  url: '/tracks'
  model: app.Track