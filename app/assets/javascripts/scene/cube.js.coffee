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

  threeUtil = new ThreeUtil
    renderer:
      antialias: true
    light:
      z: 2
      intencity: 140
    camera:
      z: 20
    run: ->
      threeUtil.render()
      window.bear.rotation.y -= -0.01 if window.bear
      cube.rotation.y -= -0.01 if window.bear
      requestAnimationFrame threeUtil.run

  jsonLoader = new THREE.JSONLoader()
  jsonLoader.load 'model/black_bear/black_bear.js', (geometries, materials) ->
    window.bear = new THREE.Mesh(geometries, new THREE.MeshFaceMaterial(materials))
    window.bear.position.set 0, 0, 0
    window.bear.scale.set 3, 3, 3
    window.bear.rotation.y = Math.PI / 5
    window.bear.overdraw = true
    threeUtil.scene.add window.bear

  threeUtil.scene.add cube

  threeUtil.run()
