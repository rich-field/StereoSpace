window.app = window.app or {}
app.Segment = Backbone.Model.extend
  urlRoot: "/segments"
  # parse: (response, options)=>
    # console.log(this, "this")
    # console.log(response, "response")
    # console.log(options, 'options')
    # this.model = response
    # this.collection = response.notes