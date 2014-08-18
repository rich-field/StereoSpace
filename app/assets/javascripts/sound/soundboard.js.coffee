$(document).ready ->
  console.log('soundboard')
  keySounds =
    81: '/audio/hk1.wav'#Q
    87: '/audio/hk4.wav'#W
    69: '/audio/ka1.wav'#E
    82: '/audio/ka2.wav'#R
    84: '/audio/lk1.wav'#T
    89: '/audio/lk2.wav'#Y
    85: '/audio/sound'#U
    73: '/audio/sound'#I
    79: '/audio/sound'#O
    80: '/audio/sound'#P
    65: '/audio/sound'#A
    83: '/audio/sound'#S
    68: '/audio/sound'#D
    70: '/audio/sound'#F
    71: '/audio/sound'#G
    72: '/audio/sound'#H
    74: '/audio/sound'#J
    75: '/audio/sound'#K
    76: '/audio/sound'#L
    90: '/audio/sound'#Z
    88: '/audio/sound'#X
    67: '/audio/sound'#C
    86: '/audio/sound'#V
    66: '/audio/sound'#B
    78: '/audio/sound'#N
    77: '/audio/sound'#M

  $(document).on 'keydown', (e) ->
    soundId = keySounds[e.keyCode]
    console.log(soundId)

        # Load the Sound with XMLHttpRequest
    playSound = (sound, silent) ->
      unless sounds[sound]

        # Note: this will load asynchronouslys
        request = new XMLHttpRequest()
        request.open "GET", "/audio/" + sound + ".wav", true
        request.responseType = "arraybuffer" # Read as binary data

        # Asynchronous callback
        request.onload = ->
          data = request.response
          sounds[sound] = data
          audioRouting sounds[sound]  unless silent

        request.send()
      else
        audioRouting sounds[sound]  unless silent
      console.log "showing fetched sounds", sounds

    audioRouting = (data) ->
      source = context.createBufferSource() # Create sound source
      #gain = context.createGain();
      buffer = context.createBuffer(data, true) # Create source buffer from raw binary
      source.buffer = buffer # Add buffered data to object
      #source.connect(gain);
      source.connect context.destination # Connect sound source to output
      source.start 0 #Important line to get the sound to play!

