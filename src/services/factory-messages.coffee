
( (ng, app)->
  'use strict'
  app.factory "MessageFactory", ($log)->
    class MessageFactory
      add: (msg) ->
        @scope.$apply ()=>
          this.messages.push msg
        return

      setupWebsocketMethods: ()->
        @ws.onopen = =>
          $log.info "onopen called", "CONNECT"
          @add "CONNECT"
          return

        @ws.onclose = =>
          $log.info "onclose called", "DISCONNECT"
          @add "DISCONNECT"
          return

        @ws.onmessage = (event) =>
          $log.info "onmessage called",  "MESSAGE: " + event.data
          @add "MESSAGE: " + event.data
          return

        @ws.onerror = (err)->
          $log.info "WEBSOCKET ERROR", err

      constructor: (@scope)->
        @messages = []
        @ws = new WebSocket("ws://localhost:8080/")
        @setupWebsocketMethods()
        $log.info "MessageFactory constructed"

    return MessageFactory

) angular, rogueLikeLike
