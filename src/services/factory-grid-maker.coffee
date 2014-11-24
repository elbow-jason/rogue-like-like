( (ng, app)->
  'use strict'

  app.factory 'GridMaker', (boardConfig)->
    class GridMaker
      constructor: (@context) ->
        @xLimit = boardConfig.xLimit
        @yLimit = boardConfig.yLimit
        @spacing = boardConfig.spacing
        @gridlines = @calculateGrid()
        @drawGrid()

      drawGrid: ()->
        for item in @gridlines.vertical
          @verticalLine item
        for item in @gridlines.horizontal
          @horizontalLine item

      calculateGrid: ()->
        #not super efficient but only needs to calc one time per client
        return {
          vertical:   [0..@xLimit].filter (x) => x % @spacing is 0
          horizontal: [0..@yLimit].filter (y) => y % @spacing is 0
        }

      drawLine: (x1, y1, x2, y2)->
        #begin a path
        @context.beginPath()
        #start at x1, y1 (e.g. 0,8)
        @context.moveTo x1, y1
        #end at x2, y2 (e.g. 10, 10)
        @context.lineTo x2, y2
        #use the contextual path to draw a line (e.g 0,8 to 10,10)
        @context.stroke()

      horizontalLine: (coord)->
        @drawLine(0, coord, @xLimit, coord)

      verticalLine: (coord)->
        @drawLine(coord, 0, coord, @yLimit)

    return GridMaker

) angular, rogueLikeLike
