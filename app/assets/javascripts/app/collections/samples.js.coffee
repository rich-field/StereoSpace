window.app = window.app or {}
app.Samples = Backbone.Collection.extend
  url: '/samples'
  model: app.Sample