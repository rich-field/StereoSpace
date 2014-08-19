$(document).ready ->
  console.log('soundboard')
  # sounds = {}
  sounds =
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