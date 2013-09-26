window.bearGroup = new THREE.Object3D()

jsonLoader = new THREE.JSONLoader()
jsonLoader.load 'model/black_bear/black_bear.js', (geometries, materials) ->
  window.bear = new THREE.Mesh(geometries, new THREE.MeshFaceMaterial(materials))
  bear.position.set 0, 0, 0
  bear.scale.set 3, 3, 3
  bear.overdraw = true
  bear.castShadow = true
  bear.receiveShadow = true
  bearGroup.add bear

jsonLoader.load 'model/rings/rings.js', (geometries, materials) ->
  window.rings = new THREE.Mesh(geometries, new THREE.MeshFaceMaterial(materials))
  rings.position.set 0, 2.8, 2.0
  rings.scale.set 0.01, 0.01, 0.01
  rings.overdraw = true
  rings.castShadow = true
  rings.receiveShadow = true
  bearGroup.add rings

baloonMaterial = new THREE.MeshPhongMaterial({ color: 0x444486 })
jsonLoader.load 'model/baloons/baloons.js', (geometries, materials) ->
  window.baloons = new THREE.Mesh(geometries, baloonMaterial)
  baloons.position.set 0, 6, 0
  baloons.scale.set 0.15, 0.15, 0.15
  baloons.overdraw = true
  baloons.castShadow = true
  baloons.receiveShadow = true
  baloons.rotation.x = - Math.PI / 2
  bearGroup.add baloons
