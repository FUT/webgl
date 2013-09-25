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
      z: 10
      x: 2
      y: 10
      intensity: 1.5
    camera:
      z: 30
      y: 20
    run: ->
      threeUtil.render()
      group.rotation.y -= -0.01
      requestAnimationFrame threeUtil.run


  window.group=new THREE.Object3D()

  groundMaterial = new THREE.MeshPhongMaterial({ color: 0x6C6C6C })
  plane = new THREE.Mesh(new THREE.PlaneGeometry(5, 5), groundMaterial)
  plane.rotation.x = -Math.PI / 2
  plane.receiveShadow = true
  group.add plane


  jsonLoader = new THREE.JSONLoader()
  jsonLoader.load 'model/black_bear/black_bear.js', (geometries, materials) ->
    window.bear = new THREE.Mesh(geometries, new THREE.MeshFaceMaterial(materials))
    bear.position.set 0, 0, 0
    bear.scale.set 3, 3, 3
    bear.overdraw = true
    bear.castShadow = true
    bear.receiveShadow = true
    group.add bear

  jsonLoader.load 'model/rings/rings.js', (geometries, materials) ->
    window.rings = new THREE.Mesh(geometries, new THREE.MeshFaceMaterial(materials))
    rings.position.set 0, 2.8, 2.0
    rings.scale.set 0.01, 0.01, 0.01
    rings.overdraw = true
    rings.castShadow = true
    rings.receiveShadow = true
    group.add rings

  baloonMaterial = new THREE.MeshLambertMaterial({
    map: THREE.ImageUtils.loadTexture('model/baloons/fur.jpg')
  })

  jsonLoader.load 'model/baloons/baloons.js', (geometries, materials) ->
    window.baloons = new THREE.Mesh(geometries, baloonMaterial)
    baloons.position.set 0, 6, 0
    baloons.scale.set 0.13, 0.13, 0.13
    baloons.overdraw = true
    baloons.castShadow = true
    baloons.receiveShadow = true
    baloons.rotation.x = - Math.PI / 2
    group.add baloons


  # group.rotation.y = Math.PI / 2
  threeUtil.scene.add group

  threeUtil.run()
