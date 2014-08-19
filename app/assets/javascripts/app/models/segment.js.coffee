window.app = window.app or {}
app.Segment = Backbone.Model.extend
  urlRoot: "/segments"
  # parse: (response, options)->
    # console.log(response)
    # console.log(options)