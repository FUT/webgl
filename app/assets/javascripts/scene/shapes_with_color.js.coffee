$ ->

  glUtil = new GLUtil ->
    @gl.clearColor 0.0, 0.0, 0.0, 1.0
    @gl.enable @gl.DEPTH_TEST

    @gl.viewport 0, 0, @gl.viewportWidth, @gl.viewportHeight
    @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT

    mat4.perspective @pMatrix, 45, @gl.viewportWidth / @gl.viewportHeight, 0.1, 100.0
    mat4.identity @mvMatrix
    mat4.translate @mvMatrix, @mvMatrix, [-1.5, 0.0, -7.0]

    for name in ['triangle', 'square']
      vertexBuffer = @buffers["#{name}_position"]
      colorBuffer = @buffers["#{name}_color"]

      @gl.bindBuffer @gl.ARRAY_BUFFER, vertexBuffer
      @gl.vertexAttribPointer @shaderProgram.vertexPositionAttribute, vertexBuffer.itemSize, @gl.FLOAT, false, 0, 0

      @gl.bindBuffer @gl.ARRAY_BUFFER, colorBuffer
      @gl.vertexAttribPointer @shaderProgram.vertexColorAttribute, colorBuffer.itemSize, @gl.FLOAT, false, 0, 0

      @setMatrixUniforms()
      @gl.drawArrays @gl.TRIANGLES, 0, vertexBuffer.numItems

      mat4.translate @mvMatrix, @mvMatrix, [3.0, 0.0, 0.0]

  glUtil.initBuffer name: 'triangle_position', itemSize: 3, data: [0.0, 1.0, 0.0, -1.0, -1.0, 0.0, 1.0, -1.0, 0.0]
  glUtil.initBuffer name: 'triangle_color',    itemSize: 4, data: [0.0, 1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0]
  glUtil.initBuffer name: 'square_position',   itemSize: 3, data: [1.0, 1.0, 0.0, -1.0, 1.0, 0.0, 1.0, -1.0, 0.0, -1.0, -1.0, 0.0]
  glUtil.initBuffer name: 'square_color',      itemSize: 4, data: [1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, -1.0, -1.0, 1.0, 1.0, 0.5, 1.0, 1.0]

  setTimeout =>
    glUtil.drawScene()
  , 1000