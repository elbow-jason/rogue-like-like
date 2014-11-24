( (ng, app)->
  'use strict'

  app.factory "MouseTracker", ()->
    class MouseTracker
      constructor: (@canvas, @context)->
        @canvas.addEventListener "mousemove", @trackMovement, false

      trackMovement: (evt) =>
        @mousePos = @getMousePos(evt)
        message = "Mouse position: #{@mousePos.x}, #{@mousePos.y}"
        @writeMessage message
        return

      getMousePos: (evt) =>
        rect = @canvas.getBoundingClientRect()
        return {
        x: Math.floor(evt.clientX - rect.left)
        y: Math.floor(evt.clientY - rect.top)
        }

      writeMessage: (message) =>
        @context.clearRect 0, 0, @canvas.width, @canvas.height
        @context.font = "10pt Calibri"
        @context.fillStyle = "black"
        @context.fillText message, 5, 12
        return
    return MouseTracker



) angular, rogueLikeLike
