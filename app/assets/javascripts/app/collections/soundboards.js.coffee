window.app = window.app or {}
app.Soundboards = Backbone.Collection.extend
  url: "/soundboards"
  model: app.Soundboard