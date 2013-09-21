class window.ThreeUtil

  tick: ->
    that = if (this == window) then window.glUtil else this
    requestAnimationFrame that.tick
    that.drawScene()
    that.animate()

  createRenderer: ->
    @container = document.getElementById 'canvas'

    # Create the Three.js renderer, add it to our div
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize @container.offsetWidth, @container.offsetHeight
    @container.appendChild @renderer.domElement

  createScene: ->
    # Create a new Three.js scene
    @scene = new THREE.Scene()

  createCamera: ->
    # Create a camera and add it to the scene
    @camera = new THREE.PerspectiveCamera 45, @container.offsetWidth / @container.offsetHeight, 1, 4000
    @camera.position.set 0, 0, 3.3333
    @scene.add @camera

  render: ->
    # Render it
    @renderer.render @scene, @camera

  constructor: (options) ->
    @createRenderer()
    @createScene()
    @createCamera()
