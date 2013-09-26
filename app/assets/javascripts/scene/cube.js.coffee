$ ->
  # Create a shaded, texture-mapped cube and add it to the scene
  # First, create the texture map
  map = THREE.ImageUtils.loadTexture('/assets/fur4.jpg')

  # Now, create a Phong material to show shading; pass in the map
  material = new THREE.MeshLambertMaterial({ map: map })

  # Create the cube geometry
  geometry = new THREE.SphereGeometry(2, 50, 50)

  # And put the geometry and material together into a mesh
  cube = new THREE.Mesh(geometry, material)
  cube.position.y = -1.7

  window.angleY = 0
  window.angleX = 0

  threeUtil = new ThreeUtil
    renderer:
      antialias: true
    light:
      z: 10
      x: 2
      y: 10
      intensity: 1.5
    camera:
      z: 50
      y: 20
    run: ->
      threeUtil.render()
      angleY += 0.1
      angleX += 0.03
      bearGroup.position.y = Math.sin(angleY) * 5 + 14
      bearGroup.position.x = Math.sin(angleX) * 5
      # sceneGroup.rotation.y -= -0.01
      requestAnimationFrame threeUtil.run

  window.sceneGroup  = new THREE.Object3D()

  sceneGroup.add forestGroup
  sceneGroup.add bearGroup

  # group.rotation.y = Math.PI / 2
  threeUtil.scene.add sceneGroup

  threeUtil.run()
