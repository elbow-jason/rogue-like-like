// Generated by CoffeeScript 1.7.1
Crafty.c("Grid", {
  init: function() {
    this.attr({
      w: Game.grid.tile.width,
      h: Game.grid.tile.height
    });
  },
  at: function(x, y) {
    if (x === undefined && y === undefined) {
      return {
        x: this.x / Game.grid.tile.width,
        y: this.y / Game.grid.tile.height
      };
    } else {
      this.attr({
        x: x * Game.grid.tile.width,
        y: y * Game.grid.tile.height
      });
      return this;
    }
  }
});

Crafty.c("Actor", {
  init: function() {
    this.requires("2D, Canvas, Grid");
  }
});

Crafty.c("Tree", {
  init: function() {
    this.requires("Actor, Color, Solid").color("rgb(20, 10, 40)");
  }
});

Crafty.c("Bush", {
  init: function() {
    this.requires("Actor, Color, Solid").color("rgb(20, 185, 40)");
  }
});

Crafty.c("Agent", {
  init: function() {
    this.requires("Actor, Fourway, Color, Collision").fourway(4).stopOnSolids().color("rgb(20, 75, 40)");
  },
  stopOnSolids: function() {
    this.onHit('Solid', this.stopMovement);
    return this;
  },
  stopMovement: function() {
    this._speed = 0;
    if (this._movement) {
      this.x -= this._movement.x;
      return this.y -= this._movement.y;
    }
  }
});
