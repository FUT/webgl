class window.Stack
  @stack: []

  @push: (element) ->
    @stack.push element

  @pop: ->
    console.log "[ERROR] Popping empty stack." if @stack.length == 0
    @stack.pop()
