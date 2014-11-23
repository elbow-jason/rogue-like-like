
( (ng, app)->
  'use strict'
  app.factory "MessageFactory", ($log)->
    class MessageFactory
      log: (msg) ->
        @scope.$apply ()=>
          this.messages.push msg
        return

      setupWebsocketMethods: ()->
        @ws.onopen = =>
          $log.info "onopen called", "CONNECT"
          @log "CONNECT"
          return

        @ws.onclose = =>
          $log.info "onclose called", "DISCONNECT"
          @log "DISCONNECT"
          return

        @ws.onmessage = (event) =>
          $log.info "onmessage called",  "MESSAGE: " + event.data
          @log "MESSAGE: " + event.data
          return

        @ws.onerror = (err)->
          $log.info "WEBSOCKET ERROR", err

      constructor: (@scope)->
        @messages = []
        @log "WTF CUH"
        @ws = new WebSocket("ws://localhost:8080/")
        $log.info "@ws = ", @ws
        @setupWebsocketMethods()
        # setup websocket with callbacks


    return MessageFactory

) angular, rogueLikeLike
