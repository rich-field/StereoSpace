window.app = window.app or {}
app.Songs = Backbone.Collection.extend
  url: '/songs'
  model: app.Song