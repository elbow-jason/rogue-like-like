
Game =
  agents: []
  edgeColor: 'rgb(20, 125, 40)'
  tileColor: 'rgb(20, 185, 40)'
  grid:
    width:  64
    height: 64
    tile:
      width:  8
      height: 8


  start: ()->
    Crafty.init 512, 512
    Crafty.background 'green'
    Game.placeAgent()
    Game.generateTiles()

  newTile: (x, y)->
    y: Game.grid.tile.height * y
    x: Game.grid.tile.width * x
    w: Game.grid.tile.width
    h: Game.grid.tile.height

  generateTiles:()->
    #...(triple dot) is exclusive
    widthArray  = [0...Game.grid.width]
    heightArray = [0...Game.grid.height]
    for x in widthArray
      for y in heightArray
        if Game.atEdge x, y
          Game.placeEdge x, y
        #else
        #  Game.placeBush x, y

  width: ()->
    @grid.width * @grid.tile.width
  height: ()->
    @grid.height * @grid.tile.height

  atEdge: (x, y)->
    return x is 0 or y is 0\
      or x is Game.grid.width - 1\
      or y is Game.grid.height- 1

  placeAgent: (x,y)->
    x = x or 5
    y = y or 5
    console.log "x, y of agent", x, y
    Game.agents.push Crafty.e('Agent').at x, y

  placeEdge: (x, y)->
    Crafty.e('Tree').at x,y

  placeBush: (x, y)->
    if Math.random() < 0.06
      Crafty.e('Bush').at x, y

  placeTile: (x, y)->
    Crafty.e('2D, Canvas, Color')
      .attr(Game.newTile(x,y))
      .color(Game.tileColor)

