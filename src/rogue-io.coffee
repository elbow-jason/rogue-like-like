

Game.io =
  messages: []
  ws: new WebSocket('ws://localhost:8080/')

Game.io.ws.onopen = (evt) =>
  console.log "closed socket", evt
  Game.start()
  return evt

Game.io.ws.onclose = (evt)=>
  console.log "closed socket", evt
  return evt

Game.io.ws.onmessage = (evt) =>
  console.lo g "message on socket", evt
  return evt

Game.io.ws.onerror = (evt)->
  console.log 'WEBSOCKET ERROR', evt
  return evt


