# Namespacing!
window.app = window.app or {}

# Makes new empty object to hold sounds in binary data.
# This will prevent unnesesary requests to the server.
app.sounds = {}

# Sets up the bound keys for sound like so:
# { keyCode: 'filename' }
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

# Sets up the function to actually play the sound
# It takes the sound as the first param and a boolean for the second
app.playSound = (sound, silent) ->

  # This will only send a request if the binary data for the wav file has not been inserted into the app.sounds object
  unless app.sounds[sound]
    # Note: this will load asynchronously
    request = new XMLHttpRequest()
    request.open "GET", "/audios/" + sound + ".wav", true
    # Read as binary data
    request.responseType = "arraybuffer"

    # When the request has finished loading
    request.onload = ->
      # Set the audioData to the response we get back
      audioData = request.response;
      # Put the data into the sound object
      app.sounds[sound] = audioData
      # Play the sound via Web audio api node setup unless the silent param is true
      app.processAudio(audioData) unless silent

    # Send the request, not waiting for the previous requests to finish
    request.send()
  else
    # Play the sound via Web audio api node setup
    app.processAudio(app.sounds[sound])

# Take the audio data and play it
app.processAudio = (data) ->
  # Decodes audiodata in the set up audiocontext
  # It takes two args:
  # 1. The data to decode
  # 2. A function that will have a buffer passed in
  app.Sound.audioContext.decodeAudioData data, (buffer) ->
    # Sets up the source(input) for the sound
    app.source = app.Sound.audioContext.createBufferSource()
    # Takes the buffer and puts it in a variable
    myBuffer = buffer
    # Sets the current source buffer to the set buffer
    app.source.buffer = myBuffer
    # Connects the source to the analyser node..
    app.source.connect app.Sound.analyserNode
    # .. and the analyser node to the destination(output)
    app.Sound.analyserNode.connect app.Sound.audioContext.destination
    # Disables looping of the sound
    app.source.loop = false

    # This is where you set the interval to get the frequency & time domain data
    # And feed it to the visualizer function
    # app.visual = setInterval (->
      # run visualiser here
      # console.log app.Sound.getFrequencyDomain()
      # console.log app.Sound.getTimeDomain()
      # return
    # ), 500

    # Plays the sound
        # The first number is how long from now to play the sound
        # The second number is the start point in the sound
        # The third number is where the sound will stop
        # These are in seconds
    app.source.start(0,0,1.8)
    return

# Load all sounds on start, with silent = true
app.playSound(app.soundKeys[sound], true) for sound of app.soundKeys

$(document).ready ->
  # listens for a keydown event
  $(document).on 'keydown', (e) ->

    # Sets var to be a value inside the key binding object
    # The keyCode is attached to the key event
    soundId = app.soundKeys[e.keyCode]
    # If the value exists
    if soundId
      # Prevent 'Sound layering'
      # This will stop the sound currently playing if the same key is pressed twice in quick succession
      app.source.stop(0) if app.currentSound == app.sounds[soundId]
      # Plays the sound on keypress
      app.playSound(soundId)
      # Sets the previously pressed key to be the current playing sound
      app.currentSound = app.sounds[soundId]


