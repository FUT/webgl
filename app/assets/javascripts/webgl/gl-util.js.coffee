class window.GLUtil
  gl: undefined
  shaderProgram: undefined
  mvMatrix: new Float32Array(16) #mat4.create()
  pMatrix: new Float32Array(16) #mat4.create()
  triangleVertexPositionBuffer: undefined
  squareVertexPositionBuffer: undefined
  canvas: undefined
  verticesBuffers: {}

  initCanvas: ->
    @canvas = document.getElementById 'canvas'

  logGLCall: (functionName, args) ->
     console.log "gl.#{functionName}(", args, ")"

  initGL: ->
    try
      @gl = @canvas.getContext("experimental-webgl")
      @gl = WebGLDebugUtils.makeDebugContext(@gl, undefined, @logGLCall)
      @gl.viewportWidth = @canvas.width
      @gl.viewportHeight = @canvas.height
    alert "Could not initialise WebGL, sorry :-("  unless @gl

  constructor: (@drawScene) ->
    @initCanvas()
    @initGL()
    @initShaders()
    console.log 'GLUtil was initialized', @

  getShader: (id) ->
    shaderScript = document.getElementById(id)
    console.log("[ERROR] No shader script with id #{id} found") unless shaderScript

    if shaderScript.type is "x-shader/x-fragment"
      shader = @gl.createShader(@gl.FRAGMENT_SHADER)
    else if shaderScript.type is "x-shader/x-vertex"
      shader = @gl.createShader(@gl.VERTEX_SHADER)
    else
      console.log "[ERROR] Unknown shader type #{shaderScripe.type}"

    @gl.shaderSource shader, shaderScript.text
    @gl.compileShader shader
    unless @gl.getShaderParameter(shader, @gl.COMPILE_STATUS)
      console.log "[ERROR] Shader compilation failed\n#{@gl.getShaderInfoLog(shader)}"

    console.log "Shader #{id} was successfully compiled"
    shader

  initShaders: ->
    fragmentShader = @getShader "shader-fs"
    vertexShader = @getShader "shader-vs"
    @shaderProgram = @gl.createProgram()
    @gl.attachShader @shaderProgram, vertexShader
    @gl.attachShader @shaderProgram, fragmentShader
    @gl.linkProgram @shaderProgram
    alert "Could not initialise shaders"  unless @gl.getProgramParameter(@shaderProgram, @gl.LINK_STATUS)
    @gl.useProgram @shaderProgram
    @shaderProgram.vertexPositionAttribute = @gl.getAttribLocation(@shaderProgram, "aVertexPosition")
    @gl.enableVertexAttribArray @shaderProgram.vertexPositionAttribute
    @shaderProgram.pMatrixUniform = @gl.getUniformLocation(@shaderProgram, "uPMatrix")
    @shaderProgram.mvMatrixUniform = @gl.getUniformLocation(@shaderProgram, "uMVMatrix")
    console.log 'Shader initialization finished'

  setMatrixUniforms: ->
    @gl.uniformMatrix4fv @shaderProgram.pMatrixUniform, false, @pMatrix
    @gl.uniformMatrix4fv @shaderProgram.mvMatrixUniform, false, @mvMatrix

  initBuffer: (name, vertices) ->
    vertexPositionBuffer = @gl.createBuffer()
    @gl.bindBuffer @gl.ARRAY_BUFFER, vertexPositionBuffer
    @gl.bufferData @gl.ARRAY_BUFFER, new Float32Array(vertices), @gl.STATIC_DRAW
    vertexPositionBuffer.itemSize = 3
    vertexPositionBuffer.numItems = vertices.length / vertexPositionBuffer.itemSize
    @verticesBuffers[name] = vertexPositionBuffer
    console.log "Buffer #{name} was initialized"
