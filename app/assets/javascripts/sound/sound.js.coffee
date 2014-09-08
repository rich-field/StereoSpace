# Sets up audiocontext to instantiate later
window.AudioContext = (->
  window.webkitAudioContext or window.AudioContext or window.mozAudioContext
)()
# Namespacing so we can use this everywhere
window.app = window.app or {}

# Audio factory
app.Sound =

  # Sets up the audio context
  # If the Web Audio API is not supported in the current browser, alert the user
  audioContextSetup: ->
    try
      @.audioContext = new (window.AudioContext or window.webkitAudioContext)()
    catch e
      alert "Web Audio API is not supported in this browser"
    return

  # Sets up the nodes to use for analysis to tie with visualistation
  setupAudioNodes: ->
    @.analyserNode = @.audioContext.createAnalyser()
    @.analyserNode.fftSize = 32 # 1024
    @.frequencyArray = new Uint8Array(@.analyserNode.frequencyBinCount)
    @.timeDomainArray = new Uint8Array(@.analyserNode.frequencyBinCount)
    # Gain node in case you want to increase volume
    @.gainNode = @.audioContext.createGain()
    return

  # ------------------------------
  # Example of an audio connection
  #
  # Source node -> Gain node-> Analyser node -> Output node
  # ------------------------------
  # connectAudioNodes: ->
    # @.sourceNode.connect @.gainNode
    # @.gainNode.connect @.analyserNode
    # @.analyserNode.connect @.audioContext.destination
    # return
  # ------------------------------

  # Functions to get the frequency and time domain of the sound
  # You need to setInterval on this to get live updating
  getFrequencyDomain: ->
    @.analyserNode.getByteFrequencyData @.frequencyArray
    @.frequencyArray
  getTimeDomain: ->
    @.analyserNode.getByteTimeDomainData @.timeDomainArray
    @.timeDomainArray

# Sets up audio ready for use
$(document).ready ->
  # Initial Audio setup
  app.Sound.audioContextSetup()
  app.Sound.setupAudioNodes()

  # app.visual = setInterval (->
  #     # run visualiser here
  #     # $('#visualizer').css('background-color', )
  #     console.log app.Sound.getFrequencyDomain()
  #     console.log app.Sound.getTimeDomain()
  #     return
  #   ), 500

