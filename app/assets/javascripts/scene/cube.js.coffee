$ ->
  threeUtil = new ThreeUtil()

  # Now, create a rectangle and add it to the scene
  geometry = new THREE.PlaneGeometry(1, 1)
  mesh = new THREE.Mesh(geometry, new THREE.MeshBasicMaterial())
  threeUtil.scene.add mesh

  threeUtil.render()
