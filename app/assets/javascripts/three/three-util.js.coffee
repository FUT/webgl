class window.ThreeUtil

  tick: ->
    that = if (this == window) then window.glUtil else this
    requestAnimationFrame that.tick
    that.drawScene()
    that.animate()

  createRenderer: (options) ->
    options.renderer ||= {}

    @container = document.getElementById 'canvas'

    # Create the Three.js renderer, add it to our div
    @renderer = new THREE.WebGLRenderer(options.renderer)
    @renderer.setSize @container.offsetWidth, @container.offsetHeight
    @container.appendChild @renderer.domElement

  createScene: (options) ->
    options.scene ||= {}

    # Create a new Three.js scene
    @scene = new THREE.Scene(options.scene)

  createCamera: (options) ->
    # Set default options
    cam = options.camera || {}
    pos = options.position || {}

    cam.angle  ||= 45
    cam.aspect ||= @container.offsetWidth / @container.offsetHeight
    cam.min    ||= 1
    cam.max    ||= 4000

    pos.x      ||= 0
    pos.y      ||= 0
    pos.z      ||= 3

    # Create a camera and add it to the scene
    @camera = new THREE.PerspectiveCamera cam.angle, cam.aspect, cam.min, cam.max
    @camera.position.set pos.x, pos.y, pos.z
    @scene.add @camera

  render: ->
    # Render it
    @renderer.render @scene, @camera

  constructor: (options) ->
    options ||= {}

    @createRenderer(options)
    @createScene(options)
    @createCamera(options)
