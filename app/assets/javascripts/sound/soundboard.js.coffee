sounds = {}
soundKeys =
    81: 'hk1'#Q
    87: 'hk4'#W
    69: 'ka1'#E
    82: 'ka2'#R
    84: 'lk1'#T
    89: 'lk2'#Y
    85: 'sound'#U
    73: 'sound'#I
    79: 'sound'#O
    80: 'sound'#P
    65: 'sound'#A
    83: 'sound'#S
    68: 'sound'#D
    70: 'sound'#F
    71: 'sound'#G
    72: 'sound'#H
    74: 'sound'#J
    75: 'sound'#K
    76: 'sound'#L
    90: 'sound'#Z
    88: 'sound'#X
    67: 'sound'#C
    86: 'sound'#V
    66: 'sound'#B
    78: 'sound'#N
    77: 'sound'#M



playSound = (sound, silent) ->
  unless sounds[sound]
    # Note: this will load asynchronously
    request = new XMLHttpRequest()
    request.open "GET", "/audio/" + sound + ".wav", true
    request.responseType = "arraybuffer" # Read as binary data

    # Asynchronous callback
    request.onload = ->
      audioData = request.response;
      sounds[sound] = audioData
      processAudio(audioData) unless silent

    request.send()
  else
    processAudio(sounds[sound])

processAudio = (data) ->
  app.Sound.audioContext.decodeAudioData data, (buffer) ->
    source = app.Sound.audioContext.createBufferSource()
    myBuffer = buffer
    source.buffer = myBuffer
    source.connect app.Sound.analyserNode
    app.Sound.analyserNode.connect app.Sound.audioContext.destination
    source.loop = false
    setInterval (->
      console.log app.Sound.getFrequencyDomain()
      return
    ), 500
    source.start(0);
    return

$(document).ready ->

  $(document).on 'keydown', (e) ->
    soundId = soundKeys[e.keyCode]
    if soundId
      console.log(soundId)
      playSound(soundId)

