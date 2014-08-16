window.app = window.app or {}
app.Timelines = Backbone.Collection.extend
  url: "/timelines"
  model: app.Timeline