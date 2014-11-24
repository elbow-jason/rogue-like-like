
( (ng, app)->
  'use strict'

  app.directive 'gameBoard', (boardConfig, GridMaker, MouseTracker)->
    restrict: 'A'
    controller: ($scope)->

    link: (scope, element) ->
      canvas  = element[0]
      context = canvas.getContext '2d'
      mouse = new MouseTracker canvas, context
      grid  = new GridMaker context
      grid.drawLine(0,0,25,25)
      return

) angular, rogueLikeLike


###
app.factory 'GridData', ()->
  gridDataObject = {}
  gridDataServices = {}

  gridDataServices.add = ()->
  GridData
###
