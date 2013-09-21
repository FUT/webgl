$ ->
  # Create a shaded, texture-mapped cube and add it to the scene
  # First, create the texture map
  map = THREE.ImageUtils.loadTexture('/assets/rails.png')

  # Now, create a Phong material to show shading; pass in the map
  material = new THREE.MeshPhongMaterial({ map: map })

  # Create the cube geometry
  geometry = new THREE.CubeGeometry(1, 1, 1)

  # And put the geometry and material together into a mesh
  cube = new THREE.Mesh(geometry, material)
  cube.rotation.x = Math.PI / 5
  cube.rotation.y = Math.PI / 5

  threeUtil = new ThreeUtil
    renderer:
      antialias: true
    run: ->
      threeUtil.render()
      cube.rotation.y -= 0.01
      cube.rotation.x -= 0.005
      requestAnimationFrame threeUtil.run

  threeUtil.scene.add cube

  threeUtil.run()
