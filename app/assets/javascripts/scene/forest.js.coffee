window.forestGroup = new THREE.Object3D()

omLoader = new THREE.OBJMTLLoader()
omLoader.load 'model/spruce/spruce.obj', 'model/spruce/spruce.mtl', (spruce) ->
  window.spruce = spruce

  addTree = =>
    newspruce = spruce.clone()
    newspruce.position.set (Math.random()*planeSizeX - planeSizeX/2)*0.9, 0, (Math.random()*planeSizeY*0.9- planeSizeY/2)*0.9
    newspruce.rotation.y = Math.random() * 100

    castReceiveShadow = (mesh) ->
      mesh.castShadow = true
      mesh.receiveShadow = true

    castReceiveShadow(mesh) for mesh in newspruce.children[0].children

    scale = Math.random() * 0.03 + 0.01
    newspruce.scale.set scale, scale, scale

    forestGroup.add newspruce

  # make forest
  trees = 20
  addTree() for i in [1..trees]

map = THREE.ImageUtils.loadTexture('/assets/grass.jpg')
groundMaterial = new THREE.MeshLambertMaterial({ map: map })
window.planeSizeX = 70
window.planeSizeY = 50

plane = new THREE.Mesh(new THREE.PlaneGeometry(planeSizeX, planeSizeY), groundMaterial)
plane.rotation.x = -Math.PI / 2
plane.receiveShadow = true
forestGroup.add plane
