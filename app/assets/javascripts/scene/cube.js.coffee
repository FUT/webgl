$ ->
  window.angleY = 0
  window.angleX = 0
  window.angleZ = 0
  window.widthX = 20
  window.widthY = 5
  window.widthZ = 20

  threeUtil = new ThreeUtil
    renderer:
      antialias: true
    light:
      z: 20
      x: 10
      y: 100
      intensity: 2.5
    camera:
      z: 70
      y: 40
      x: 10
    run: ->
      threeUtil.render()
      angleY += 0.01
      angleX += 0.003
      angleZ += 0.004
      bearGroup.position.y = Math.sin(angleY) * widthY + 14
      bearGroup.position.x = Math.sin(angleX) * widthX
      bearGroup.position.z = Math.sin(angleZ) * widthZ

      bearGroup.rotation.x = -Math.sin(angleX) * 0.3
      bearGroup.rotation.y = -Math.sin(angleY) * 0.3
      bearGroup.rotation.z = -Math.sin(angleZ) * 0.3

      sceneGroup.rotation.y -= -0.001
      requestAnimationFrame threeUtil.run

  window.sceneGroup  = new THREE.Object3D()

  bearGroup.position.z = -10

  sceneGroup.add forestGroup
  sceneGroup.add bearGroup

  # group.rotation.y = Math.PI / 2
  threeUtil.scene.add sceneGroup

  threeUtil.run()
