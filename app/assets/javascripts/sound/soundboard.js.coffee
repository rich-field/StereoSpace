window.app = window.app or {}

app.sounds = {}
app.soundKeys =
    81: 'q'#Q
    87: 'w'#W
    69: 'e'#E
    82: 'r'#R
    84: 't'#T
    89: 'y'#Y
    85: 'u'#U
    73: 'i'#I
    79: 'o'#O
    80: 'p'#P
    65: 'a'#A
    83: 's'#S
    68: 'd'#D
    70: 'f'#F
    71: 'g'#G
    72: 'h'#H
    74: 'j'#J
    75: 'k'#K
    76: 'l'#L
    90: 'z'#Z
    88: 'x'#X
    67: 'c'#C
    86: 'v'#V
    66: 'b'#B
    78: 'n'#N
    77: 'm'#M
    186: 'semicolon'#;
    191: 'slash'#/
    190: 'fullstop'#.
    188: 'comma'#,

app.playSound = (sound, silent) ->
  unless app.sounds[sound]
    # Note: this will load asynchronously
    request = new XMLHttpRequest()
    request.open "GET", "/audio/" + sound + ".wav", true
    request.responseType = "arraybuffer" # Read as binary data

    # Asynchronous callback
    request.onload = ->
      audioData = request.response;
      app.sounds[sound] = audioData
      app.processAudio(audioData) unless silent

    request.send()
  else
    app.processAudio(app.sounds[sound])

app.processAudio = (data) ->
  app.Sound.audioContext.decodeAudioData data, (buffer) ->
    source = app.Sound.audioContext.createBufferSource()
    myBuffer = buffer
    source.buffer = myBuffer
    source.connect app.Sound.analyserNode
    app.Sound.analyserNode.connect app.Sound.audioContext.destination
    source.loop = false
    # setInterval (->
      # console.log app.Sound.getFrequencyDomain()
      # return
    # ), 500
    source.start(0)

    # source.stop(0)
    return

$(document).ready ->
  # Load all sounds when doc is ready
  app.playSound(app.soundKeys[sound], true) for sound of app.soundKeys

  $(document).on 'keydown', (e) ->
    soundId = app.soundKeys[e.keyCode]
    if soundId
      app.playSound(soundId)

