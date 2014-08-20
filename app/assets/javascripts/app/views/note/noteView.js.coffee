window.app = window.app or {}

app.NoteView = Backbone.View.extend
  tagName: 'div'
  className: 'note'
  events:
    'click': 'selectNote'
    'keydown': 'keyControls'
    'mouseover': 'playNote'

  initialize: ->

    _.bindAll(this, 'keyControls')
    _.bindAll(this, 'deleteNote')
    $(document).on 'keydown', (e) =>
      @.keyControls(e)


    console.log('NoteView initialized')
    setInterval ->
      # console.log('going')
    # while app.playing == true
      if $('.seeker').css('left') == parseInt( $('.segment').css('left') ) + parseInt( $('.note').css('left') ) + 10 + 'px'
        console.log('inside the if')
        app.seekerOnNote = true
        @.playNote
    , 10


  render: ->
    @.$el.css('left', @.model.get('point_in_segment'))
    @.$el.attr('data-noteid', @.model.get('id'))
    # <div class='note' data-note-id='89'>
    return @$el

  playNote: ->
    # console.log('homajebus plz work')
    console.log(@.model.get('sample_path'))
    app.playSound( @.model.get('sample_path').replace(".wav","").replace("/audios/", "") )


  selectNote: (e) ->
    e.stopPropagation()
    $('.note.selected').removeClass('selected')
    @.$el.toggleClass('selected')
    app.selectedNote = @.model

  keyControls: (e) ->
    if e.keyCode == 8 and app.selectedNote
      e.stopPropagation()
      e.preventDefault()
      @.deleteNote()

  deleteNote: ->
      $('.note.selected').remove()
      app.selectedNote.destroy()
      app.selectedNote = null