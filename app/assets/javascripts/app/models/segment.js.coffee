window.app = window.app or {}
app.Segment = Backbone.Model.extend
  urlRoot: "/segments"
  parse: (response, options) =>
    # gets the notes and puts it into a collection
    response.notes = new app.Notes(response.notes)
    return response