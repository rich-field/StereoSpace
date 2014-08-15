window.app = window.app or {}
app.Notes = Backbone.Collection.extend
  url: "/notes"
  model: app.Note