# app.notesToPlay =
#   10: 'g'
#   123: 'p'
#   200: 'semicolon'


app.seekerPosition = 0

$(document).ready ->
  setInterval ->
    app.seekerPosition++
    app.playSound( app.notesToPlay[app.seekerPosition] ) if app.notesToPlay[app.seekerPosition]
    $('.seeker').css('left', app.seekerPosition * 1.7)
  , 1