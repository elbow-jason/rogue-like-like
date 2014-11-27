

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
  console.log "message on socket", evt
  console.log "message data on socket", evt.data
  return evt

Game.io.ws.onerror = (evt)->
  console.log 'WEBSOCKET ERROR', evt
  return evt



