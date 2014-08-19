window.app = window.app or {}
app.Segment = Backbone.Model.extend
  urlRoot: "/segments"
  parse: (response, options) =>
    console.log(response.notes)
    response.notes = new app.Notes(response.notes)
    return response