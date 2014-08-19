window.AudioContext = (->
  window.webkitAudioContext or window.AudioContext or window.mozAudioContext
)()
window.app = window.app or {}
# Audio factory
app.Sound =
  audioContextSetup: ->
    try
      @.audioContext = new (window.AudioContext or window.webkitAudioContext)()
    catch e
      alert "Web Audio API is not supported in this browser"
    return

  setupAudioNodes: ->
    @.analyserNode = @.audioContext.createAnalyser()
    @.analyserNode.fftSize = 32 # 1024
    @.frequencyArray = new Uint8Array(@.analyserNode.frequencyBinCount)
    @.timeDomainArray = new Uint8Array(@.analyserNode.frequencyBinCount)

    @.gainNode = @.audioContext.createGain()
    return

  # Example of Source node->Gain node-> Analyser node -> Output node
  # connectAudioNodes: ->
    # @.sourceNode.connect @.gainNode
    # @.gainNode.connect @.analyserNode
    # @.analyserNode.connect @.audioContext.destination
    # return

  getFrequencyDomain: ->
    @.analyserNode.getByteFrequencyData @.frequencyArray
    @.frequencyArray

  getTimeDomain: ->
    @.analyserNode.getByteTimeDomainData @.timeDomainArray
    @.timeDomainArray


$(document).ready ->
  # Initial Audio setup
  app.Sound.audioContextSetup()
  app.Sound.setupAudioNodes()

