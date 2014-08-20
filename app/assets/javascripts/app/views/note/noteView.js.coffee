window.app = window.app or {}

app.NoteView = Backbone.View.extend
  tagName: 'div'
  className: 'note'
  events:
    'mouseover': 'playNote'

  initialize: ->
    console.log('NoteView initialized')
    setInterval ->
    # while app.playing == true
      if $('.seeker').css('left') == parseInt( $('.segment').css('left') ) + parseInt( $('.note').css('left') ) + 10 + 'px'
        console.log('inside the if')
        app.seekerOnNote = true
        @.playNote
    , 1


  render: ->
    @$el.css('left', @.model.get('point_in_segment'))
    return @$el


  playNote: ->
    # console.log('homajebus plz work')
    console.log(@.model.get('sample_path'))
    app.playSound( @.model.get('sample_path').replace(".wav","").replace("/audios/", "") )


