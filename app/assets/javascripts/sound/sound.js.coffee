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

  createAudioObject: (file) ->
    @.audio0 = new Audio()
    # @.audio0.src = "/audio/kkjh_trustissues.mp3"
    @.audio0.src = '/audio/' + file + '.wav'
    # @.audio0.src = @.audioContext.createMediaStreamSource(stream)
    @.audio0.controls = true
    @.audio0.autoplay = false
    @.audio0.loop = true
    return

  setupAudioNodes: ->
    @.sourceNode = @.audioContext.createMediaElementSource(@.audio0)
    @.analyserNode = @.audioContext.createAnalyser()
    @.analyserNode.fftSize = 32 # 1024
    @.frequencyArray = new Uint8Array(@.analyserNode.frequencyBinCount)
    @.timeDomainArray = new Uint8Array(@.analyserNode.frequencyBinCount)

    @.gainNode = @.audioContext.createGain()
    return

  connectAudioNodes: ->
    @.sourceNode.connect @.gainNode
    @.gainNode.connect @.analyserNode
    @.analyserNode.connect @.audioContext.destination
    return

  getFrequencyDomain: ->
    @.analyserNode.getByteFrequencyData @.frequencyArray
    @.frequencyArray

  getTimeDomain: ->
    @.analyserNode.getByteTimeDomainData @.timeDomainArray
    @.timeDomainArray


$(document).ready ->

  # Initial Audio setup
  app.Sound.audioContextSetup()
  app.Sound.createAudioObject('lk1')
  # lowKick = Sound.createAudioObject('lk1')
  # highKick = Sound.createAudioObject('hk1')
  app.Sound.setupAudioNodes()
  app.Sound.connectAudioNodes()
  # Sound.gainNode.gain.value = 500.5;

  # Appends the Audio object (audio0), which in modern browsers will appear
  # as a player in HTML5!!
  $("body").append app.Sound.audio0
  # $("body").append highKick

  # Function that runs when #player audio is playing sound =)
  # Currently set to console log freq analysis data.
  $("body audio").on "playing", ->
    setInterval (->
      console.log app.Sound.getFrequencyDomain()
      return
    ), 500
    return

  return
