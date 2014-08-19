$(document).ready ->
  console.log('soundboard')
  # sounds = {}
  sounds =
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

  $(document).on 'keydown', (e) ->
    soundId = sounds[e.keyCode]
    console.log(soundId)

        # Load the Sound with XMLHttpRequest
    playSound = (sound, silent) ->
      unless sounds[sound]
        source = app.Sound.audioContext.createBufferSource()
        # Note: this will load asynchronouslys
        request = new XMLHttpRequest()
        request.open "GET", "/audio/" + sound + ".wav", true
        request.responseType = "arraybuffer" # Read as binary data

        # Asynchronous callback
        request.onload = ->
          audioData = request.response;

          app.Sound.audioContext.decodeAudioData audioData, (buffer) ->
            myBuffer = buffer
            source.buffer = myBuffer
            source.connect app.Sound.audioContext.destination
            source.loop = false
            source.start(0);
            return


        request.send()
      console.log "showing fetched sounds", sounds

    playSound(soundId)