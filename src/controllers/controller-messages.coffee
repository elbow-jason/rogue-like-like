( (ng, app)->
  'use strict'
  app.controller "MessagesController", ($scope, MessageFactory)->
    $scope.view = new MessageFactory($scope)
) angular, rogueLikeLike
