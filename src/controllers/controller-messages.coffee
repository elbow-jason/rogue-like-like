( (ng, app)->
  'use strict'
  app.controller "MessagesController", ($scope, $log, MessageFactory)->
    $scope.view = new MessageFactory($scope)
    $log.info "MessagesController is up"
) angular, rogueLikeLike
