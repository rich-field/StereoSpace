window.app = window.app or {}
app.Segment = Backbone.Collection.extend
  url: '/segments'
  model: app.Segment