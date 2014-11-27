
Game =
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
    Crafty.e('Agent').at x, y

  placeEdge: (x, y)->
    Crafty.e('Tree').at x,y

  placeBush: (x, y)->
    if Math.random() < 0.06
      Crafty.e('Bush').at x, y

  placeTile: (x, y)->
    Crafty.e('2D, Canvas, Color')
      .attr(Game.newTile(x,y))
      .color(Game.tileColor)

window.addEventListener 'load', Game.start


###

class Tile
  constructor: (@x, @y)->
    @width = 8
    @height = 8
    @contains = []

class World
  constructor: (@xLimit, @yLimit)->
    @tiles = []


        @tiles.push new Tile x, y

  sprites:->
    grass1: [0,0]
    grass2: [1,0]
    grass3: [2,0]
    grass4: [3,0]
    flower: [0,1]
    bush1:  [0,2]
    bush2:  [1,2]
    player: [0,3]

  generateWorld:->

    #generate the grass along the x-axis
    i = 0
    while i < 25
      #generate the grass along the y-axis
      j = 0
      while j < 20

  generateGrass:(i, j)->
        grassType = Crafty.randRange(1, 4)
        Crafty.e("2D, Canvas, grass" + grassType).attr
          x: i * 16
          y: j * 16


        #1/50 chance of drawing a flower and only within the bushes
        if i > 0 and i < 24 and j > 0 and j < 19 and Crafty.randRange(0, 50) > 49
          Crafty.e("2D, DOM, flower, Animate").attr(
            x: i * 16
            y: j * 16
          ).animate("wind", 0, 1, 3).bind "enterframe", ->
            @animate "wind", 80  unless @isPlaying()
            return

        j++
      i++

    #create the bushes along the x-axis which will form the boundaries
    i = 0

    while i < 25
      Crafty.e("2D, Canvas, wall_top, bush" + Crafty.randRange(1, 2)).attr
        x: i * 16
        y: 0
        z: 2

      Crafty.e("2D, DOM, wall_bottom, bush" + Crafty.randRange(1, 2)).attr
        x: i * 16
        y: 304
        z: 2

      i++

    #create the bushes along the y-axis
    #we need to start one more and one less to not overlap the previous bushes
    i = 1

    while i < 19
      Crafty.e("2D, DOM, wall_left, bush" + Crafty.randRange(1, 2)).attr
        x: 0
        y: i * 16
        z: 2

      Crafty.e("2D, Canvas, wall_right, bush" + Crafty.randRange(1, 2)).attr
        x: 384
        y: i * 16
        z: 2

      i++
    return


window.onload = ->

  #start crafty


  #turn the sprite map into usable components

  #method to randomy generate the map
  world = new World 25, 20
  Crafty.init 400, 320
  Crafty.canvas()
  Crafty.scene "loading", ->

  #Crafty.sprite 16, "sprite.png",

  #the loading screen that will display while our assets load
    #load takes an array of assets and a callback when complete
    #Crafty.load ["sprite.png"], ->
      #Crafty.scene "main" #when everything is loaded, run the main scene
      #return


    #black background with some loading text
    Crafty.background "#000"
    Crafty.e("2D, DOM, Text").attr(
      w: 100
      h: 20
      x: 150
      y: 120
    ).text("Loading").css "text-align": "center"
    return


  #automatically play the loading scene
  Crafty.scene "loading"
  Crafty.scene "main", ->
    generateWorld()
    Crafty.c "CustomControls",
      __move:
        left: false
        right: false
        up: false
        down: false

      _speed: 3
      CustomControls: (speed) ->
        @_speed = speed  if speed
        move = @__move
        @bind "enterframe", ->

          #move the player in a direction depending on the booleans
          #only move the player in one direction at a time (up/down/left/right)
          if @isDown("RIGHT_ARROW")
            @x += @_speed
          else if @isDown("LEFT_ARROW")
            @x -= @_speed
          else if @isDown("UP_ARROW")
            @y -= @_speed
          else @y += @_speed  if @isDown("DOWN_ARROW")
          return

        this


    #create our player entity with some premade components
    player = Crafty.e("2D, Canvas, player, Controls, CustomControls, Animate, Collision").attr(
      x: 160
      y: 144
      z: 1
    ).CustomControls(1).animate("walk_left", 6, 3, 8).animate("walk_right", 9, 3, 11).animate("walk_up", 3, 3, 5).animate("walk_down", 0, 3, 2).bind("enterframe", (e) ->
      if @isDown("LEFT_ARROW")
        @stop().animate "walk_left", 10  unless @isPlaying("walk_left")
      else if @isDown("RIGHT_ARROW")
        @stop().animate "walk_right", 10  unless @isPlaying("walk_right")
      else if @isDown("UP_ARROW")
        @stop().animate "walk_up", 10  unless @isPlaying("walk_up")
      else @stop().animate "walk_down", 10  unless @isPlaying("walk_down")  if @isDown("DOWN_ARROW")
      return
    ).bind("keyup", (e) ->
      @stop()
      return
    ).collision().onHit("wall_left", ->
      @x += @_speed
      @stop()
      return
    ).onHit("wall_right", ->
      @x -= @_speed
      @stop()
      return
    ).onHit("wall_bottom", ->
      @y -= @_speed
      @stop()
      return
    ).onHit("wall_top", ->
      @y += @_speed
      @stop()
      return
    )
    return

  return
###
