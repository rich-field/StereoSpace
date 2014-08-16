window.AudioContext = (->
  window.webkitAudioContext or window.AudioContext or window.mozAudioContext
)()

# Audio factory
Sound =
  audioContextSetup: ->
    try
      Sound.audioContext = new (window.AudioContext or window.webkitAudioContext)()
    catch e
      alert "Web Audio API is not supported in this browser"
    return

  createAudioObject: ->
    Sound.audio0 = new Audio()
    Sound.audio0.src = "/audio/kkjh_trustissues.mp3"
    Sound.audio0.controls = true
    Sound.audio0.autoplay = false
    Sound.audio0.loop = true
    return

  setupAudioNodes: ->
    Sound.sourceNode = Sound.audioContext.createMediaElementSource(Sound.audio0)
    Sound.analyserNode = Sound.audioContext.createAnalyser()
    Sound.analyserNode.fftSize = 1024
    Sound.frequencyArray = new Uint8Array(Sound.analyserNode.frequencyBinCount)

    Sound.timeDomainArray = new Uint8Array(Sound.analyserNode.frequencyBinCount)
    return

  connectAudioNodes: ->
    Sound.sourceNode.connect Sound.analyserNode
    Sound.analyserNode.connect Sound.audioContext.destination
    return

  getFrequencyDomain: ->
    Sound.analyserNode.getByteFrequencyData Sound.frequencyArray
    Sound.frequencyArray

  getTimeDomain: ->
    Sound.analyserNode.getByteTimeDomainData Sound.timeDomainArray
    Sound.timeDomainArray


$(document).ready ->

  # Initial Audio setup
  Sound.audioContextSetup()
  Sound.createAudioObject()
  Sound.setupAudioNodes()
  Sound.connectAudioNodes()

  # Appends the Audio object (audio0), which in modern browsers will appear
  # as a player in HTML5!!
  $("#visualiser").append Sound.audio0

  # Function that runs when #player audio is playing sound =)
  # Currently set to console log freq analysis data.
  $("#timelines audio").on "playing", ->
    setInterval (->
      console.log Sound.frequencyArray
      return
    ), 500
    return

  return
