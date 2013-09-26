window.forestGroup = new THREE.Object3D()

omLoader = new THREE.OBJMTLLoader()
omLoader.load 'model/spruce/spruce.obj', 'model/spruce/spruce.mtl', (spruce) ->
  window.spruce = spruce

  addTree = =>
    newspruce = spruce.clone()
    newspruce.position.set Math.random()*planeSize - planeSize/2, 0, Math.random()*planeSize - planeSize/2

    scale = Math.random() * 0.03 + 0.01
    newspruce.scale.set scale, scale, scale

    forestGroup.add newspruce

  # make forest
  trees = 10
  addTree() for i in [1..trees]

groundMaterial = new THREE.MeshPhongMaterial({ color: 0x3C4C2C })
window.planeSize = 30
plane = new THREE.Mesh(new THREE.PlaneGeometry(planeSize, planeSize), groundMaterial)
plane.rotation.x = -Math.PI / 2
plane.receiveShadow = true
forestGroup.add plane
