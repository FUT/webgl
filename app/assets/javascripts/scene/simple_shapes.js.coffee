$ ->

  glUtil = new GLUtil ->
    @gl.clearColor 0.0, 0.0, 0.0, 1.0
    @gl.enable glUtil.gl.DEPTH_TEST

    @gl.viewport 0, 0, @gl.viewportWidth, @gl.viewportHeight
    @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT

    mat4.perspective @pMatrix, 45, @gl.viewportWidth / @gl.viewportHeight, 0.1, 100.0
    mat4.identity @mvMatrix
    mat4.translate @mvMatrix, @mvMatrix, [-1.5, 0.0, -7.0]

    for own name, buffer of @verticesBuffers
      @gl.bindBuffer @gl.ARRAY_BUFFER, buffer
      @gl.vertexAttribPointer @shaderProgram.vertexPositionAttribute, buffer.itemSize, @gl.FLOAT, false, 0, 0
      @setMatrixUniforms()
      @gl.drawArrays @gl.TRIANGLES, 0, buffer.numItems

      mat4.translate @mvMatrix, @mvMatrix, [3.0, 0.0, 0.0]

  glUtil.initBuffer 'triangle', [0.0, 1.0, 0.0, -1.0, -1.0, 0.0, 1.0, -1.0, 0.0]
  glUtil.initBuffer 'square', [1.0, 1.0, 0.0, -1.0, 1.0, 0.0, 1.0, -1.0, 0.0, -1.0, -1.0, 0.0]

  setTimeout =>
    glUtil.drawScene()
  , 1000
