# Namespacing
window.app = window.app or {}

# Preloader function
# The preloader div will not disappear until assets are loaded
window.onload = ->
  $(document).ready ->

    # Delays the preloader fading out by 2 seconds after everything has loaded
    $('#preloader').delay(1000).fadeOut()

    # Grabs templates off the page for use in views
    app.templates = {
      appView: $('#app-template').html()
      songsView: $('#songs-template').html()
      songView: $('#song-template').html()
      songShowView: $('#song-show-template').html()
      timelineView: $('#timeline-template').html()
      timelinesView: $('#timelines-template').html()
      segmentView: $('#segment-template').html()
    }

    # Instaniates new collection to fetch later
    app.songs = new app.Songs

    # Fetches all songs
    app.songs.fetch().done ->

      # Starts router when done fetching
      app.router = new app.Router
      Backbone.history.start()