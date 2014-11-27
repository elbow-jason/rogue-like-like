# The Grid component allows an element to be located
#  on a grid of tiles
Crafty.c "Grid",
  init: ->
    @attr
      w: Game.grid.tile.width
      h: Game.grid.tile.height
    return

  # Locate this entity at the given position on the grid
  at: (x, y) ->
    if x is `undefined` and y is `undefined`
      x: @x / Game.grid.tile.width
      y: @y / Game.grid.tile.height
    else
      @attr
        x: x * Game.grid.tile.width
        y: y * Game.grid.tile.height

      this


# An "Actor" is an entity that is drawn in 2D on canvas
#  via our logical coordinate grid
Crafty.c "Actor",
  init: ->
    @requires "2D, Canvas, Grid"
    return


# A Tree is just an Actor with a certain color
Crafty.c "Tree",
  init: ->
    @requires("Actor, Color, Solid").color "rgb(20, 10, 40)"
    return


# A Bush is just an Actor with a certain color
Crafty.c "Bush",
  init: ->
    @requires("Actor, Color, Solid").color "rgb(20, 185, 40)"
    return

Crafty.c "Agent",
  init: ->
    @requires("Actor, Fourway, Color, Collision")
      .fourway(4)
      .stopOnSolids()
      .color("rgb(20, 75, 40)")
      .bind("KeyUp", (evt) =>
        console.log "keyup", evt, {x: @x, y:@y}
      ).bind("Move", (evt) =>
        console.log "move:", evt
      )
    console.log  "Agent:", @._movement
    return
  stopOnSolids:->
    @onHit 'Solid', @stopMovement
    return @

  stopMovement:->
    @_speed = 0
    if @_movement
      this.x -= @_movement.x
      this.y -= @_movement.y
