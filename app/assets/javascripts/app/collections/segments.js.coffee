window.app = window.app or {}
app.Segments = Backbone.Collection.extend
  url: '/segments'
  model: app.Segment