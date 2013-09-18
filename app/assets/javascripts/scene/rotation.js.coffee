$ ->
  rad = 0

  window.glUtil = new GLUtil
    drawScene: ->
      @initScene()

      for name in ['triangle', 'square']
        vertexBuffer = @buffers["#{name}_position"]
        colorBuffer = @buffers["#{name}_color"]

        Stack.push vec4.clone(@mvMatrix)
        mat4.rotate @mvMatrix, @mvMatrix, rad, [1, 0, 0]

        @gl.bindBuffer @gl.ARRAY_BUFFER, vertexBuffer
        @gl.vertexAttribPointer @shaderProgram.vertexPositionAttribute, vertexBuffer.itemSize, @gl.FLOAT, false, 0, 0

        @gl.bindBuffer @gl.ARRAY_BUFFER, colorBuffer
        @gl.vertexAttribPointer @shaderProgram.vertexColorAttribute, colorBuffer.itemSize, @gl.FLOAT, false, 0, 0

        @setMatrixUniforms()
        @gl.drawArrays @gl.TRIANGLES, 0, vertexBuffer.numItems

        @vmMatrix = Stack.pop()

        mat4.translate @mvMatrix, @mvMatrix, [3.0, 0.0, 0.0]

    animate: ->
      rad += 0.03

    initBuffers: ->
      @initBuffer name: 'triangle_position', itemSize: 3, data: [0.0, 1.0, 0.0, -1.0, -1.0, 0.0, 1.0, -1.0, 0.0]
      @initBuffer name: 'triangle_color',    itemSize: 4, data: [0.0, 1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0]
      @initBuffer name: 'square_position',   itemSize: 3, data: [1.0, 1.0, 0.0, -1.0, 1.0, 0.0, 1.0, -1.0, 0.0, -1.0, -1.0, 0.0]
      @initBuffer name: 'square_color',      itemSize: 4, data: [1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, -1.0, -1.0, 1.0, 1.0, 0.5, 1.0, 1.0]
