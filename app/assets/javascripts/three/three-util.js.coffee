class window.ThreeUtil

  createRenderer: (options) ->
    options.renderer ||= {}

    @container = document.getElementById 'canvas'

    # Create the Three.js renderer, add it to our div
    @renderer = new THREE.WebGLRenderer(options.renderer)
    @renderer.setSize @container.offsetWidth, @container.offsetHeight
    @renderer.setClearColor 0xccdcec, 1
    @renderer.shadowMapSoft = true

    @container.appendChild @renderer.domElement

  createScene: (options) ->
    options.scene ||= {}

    # Create a new Three.js scene
    @scene = new THREE.Scene(options.scene)

  createCamera: (options) ->
    # Set default options
    cam = options.camera || {}

    cam.angle  ||= 45
    cam.aspect ||= @container.offsetWidth / @container.offsetHeight
    cam.min    ||= 1
    cam.max    ||= 4000

    cam.x      ||= 0
    cam.y      ||= 0
    cam.z      ||= 3

    # Create a camera and add it to the scene
    edgeLen = 20
    # @camera = new THREE.OrthographicCamera( -edgeLen*cam.aspect, edgeLen*cam.aspect, edgeLen, -edgeLen, 1, 1000 )
    @camera = new THREE.PerspectiveCamera cam.angle, cam.aspect, cam.min, cam.max
    @camera.position.set cam.x, cam.y, cam.z

    @camera.lookAt({ x: 0, y: 10, z: 0 })
    @scene.add @camera

  createLight: (options) ->
    light = options.light || {}

    light.color     || = 0xffffff
    light.intensity || = 1.5

    light.x         || = 0
    light.y         || = 0
    light.z         || = 1

    # Create a directional light to show off the object
    @light = new THREE.DirectionalLight light.color, light.intensity
    @light.position.set light.x, light.y, light.z
    @light.castShadow = true
    @light.shadowDarkness = 0.5
    @light.shadowCameraVisible = true

    @light.shadowCameraRight    =  5
    @light.shadowCameraLeft     = -5
    @light.shadowCameraTop      =  5
    @light.shadowCameraBottom   = -5

    @scene.add @light


  render: ->
    # Render it
    @renderer.render @scene, @camera

  constructor: (options) ->
    options ||= {}

    @run = options.run

    @createRenderer(options)
    @createScene(options)
    @createCamera(options)
    @createLight(options)
